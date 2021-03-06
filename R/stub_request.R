#' Stub an http request
#'
#' @export
#' @param method (character) HTTP method, one of "get", "post", "put", "patch",
#' "head", "delete", "options" - or the special "any" (for any method)
#' @param uri (character) The request uri. Can be a full uri, partial, or a
#' regular expression to match many incantations of a uri. required.
#' @param uri_regex (character) A URI represented as regex. See examples
#' @return an object of class `StubbedRequest`, with print method describing
#' the stub.
#' @details Internally, this calls [StubbedRequest] which handles the logic
#'
#' See [stub_registry()] for listing stubs, [stub_registry_clear()]
#' for removing all stubs and [remove_request_stub()] for removing specific
#' stubs
#' @seealso [wi_th()], [to_return()]
#' @examples \dontrun{
#' # basic stubbing
#' stub_request("get", "https://httpbin.org/get")
#' stub_request("post", "https://httpbin.org/post")
#'
#' # list stubs
#' stub_registry()
#'
#' # add header
#' stub_request("get", "https://httpbin.org/get") %>%
#'    wi_th(headers = list('User-Agent' = 'R'))
#'
#' # add expectation with to_return
#' stub_request("get", "https://httpbin.org/get") %>%
#'   wi_th(
#'     query = list(hello = "world"),
#'     headers = list('User-Agent' = 'R')) %>%
#'   to_return(status = 200, body = "stuff", headers = list(a = 5))
#'
#' # list stubs again
#' stub_registry()
#'
#' # regex
#' stub_request("get", uri_regex = ".+ample\\..")
#'
#' # clear all stubs
#' stub_registry_clear()
#' }
stub_request <- function(method = "get", uri = NULL, uri_regex = NULL) {
  if (is.null(uri) && is.null(uri_regex)) {
    stop("one of uri or uri_regex is required", call. = FALSE)
  }
  tmp <- StubbedRequest$new(method = method, uri = uri, uri_regex = uri_regex)
  webmockr_stub_registry$register_stub(tmp)
  return(tmp)
}
