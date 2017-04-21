#' crul library adapter
#'
#' @export
#' @family http_lib_adapters
#' @details This adapter modifies \pkg{crul} to allow mocking HTTP requests
#' when one is using \pkg{crul} in their code
CrulAdapter <- R6::R6Class(
  'CrulAdapter',
  public = list(
    name = "crul_adapter",

    enable = function() {
      message("CrulAdapter enabled!")
      webmockr_lightswitch$crul <- TRUE
    },

    disable = function() {
      message("CrulAdapter disabled!")
      webmockr_lightswitch$crul <- FALSE
      self$remove_crul_stubs()
    },

    build_crul_request = function(x) {
      RequestSignature$new(
        method = x$method,
        uri = x$url$url,
        options = list(
          body = x$body %||% NULL,
          headers = x$headers %||% NULL,
          proxies = x$proxies %||% NULL,
          auth = x$auth %||% NULL
        )
      )
    },

    build_crul_response = function(req, resp) {
      crul::HttpResponse$new(
        method = req$method,
        url = req$url$url,
        status_code = resp$status_code,
        request_headers = c(useragent = req$options$useragent, req$headers),
        #response_headers = list(),
        response_headers = {
          if (grepl("^ftp://", resp$url)) {
            list()
          } else {
            hh <- rawToChar(resp$response_headers %||% raw(0))
            if (is.null(hh) || nchar(hh) == 0) {
              list()
            } else {
              crul:::headers_parse(curl::parse_headers(hh))
            }
          }
        },
        modified = resp$modified,
        times = resp$times,
        content = resp$content,
        handle = req$url$handle,
        request = req
      )
    },

    handle_request = function(req) {
      # put request in request registry
      request_signature <- self$build_crul_request(req)
      webmockr_request_registry$register_request(
        request = request_signature$to_s()
      )

      if (request_is_in_cache(request_signature)) {
        # if real requests NOT allowed
        # even if net connects allowed, we check if stubbed found first
        #  and return that if found
        # get stub with response
        ss <- webmockr_stub_registry$find_stubbed_request(request_signature)[[1]]
        resp <- Response$new()
        resp$set_url(ss$uri)
        resp$set_body(ss$body)
        resp$set_request_headers(ss$request_headers)
        resp$set_response_headers(ss$response_headers)

        # generate crul response
        crul_resp <- self$build_crul_response(req, resp)

      } else if (webmockr_net_connect_allowed()) {
        cat("howdy how")
        # if real requests ARE allowed && nothing found above
        tmp <- crul::HttpClient$new(url = req$url$url)
        #tmp2 <- tmp$.__enclos_env__$private$crul_fetch(req)
        tmp2 <- crul:::crul_fetch(req)
        crul_resp <- self$build_crul_response(req, tmp2)
      } else {
        # no stubs found and net connect not allowed
        stop("net connections not allowed", call. = FALSE)
      }

      return(crul_resp)
    },

    remove_crul_stubs = function() {
      webmockr_stub_registry$remove_all_request_stubs()
    }
  )
)