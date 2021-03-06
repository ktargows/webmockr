#' Set additional parts of a stubbed request
#'
#' Set query params, request body, and/or request headers
#'
#' @export
#' @param .data input. Anything that can be coerced to a `StubbedRequest` class
#' object
#' @param ... Comma separated list of variable names, passed on
#' to [lazyeval::lazy_dots()]. accepts the following: query, body,
#' headers
#' @param .dots	Used to work around non-standard evaluation
#' @details `with` is a function in the `base` package, so we went with
#' `wi_th`
#' @return an object of class `StubbedRequest`, with print method describing
#' the stub
#' @note see examples in [stub_request()]
wi_th <- function(.data, ...) {
  wi_th_(.data, .dots = lazyeval::lazy_dots(...))
}

#' @export
#' @rdname wi_th
wi_th_ <- function(.data, ..., .dots) {
  tmp <- lazyeval::all_dots(.dots, ...)
  if (length(tmp) == 0) {
    z <- NULL
  } else {
    z <- lapply(tmp, function(x) eval(x$expr))
  }
  .data$with(
    query = z$query,
    body = z$body,
    headers = z$headers
  )
  return(.data)
}
