% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/StubbedRequest.R
\docType{data}
\name{StubbedRequest}
\alias{StubbedRequest}
\title{StubbedRequest class}
\arguments{
\item{method}{the HTTP method (any, head, get, post, put,
patch, or delete). "any" matches any HTTP method. required.}

\item{uri}{(character) request URI. either this or \code{uri_regex}
required}

\item{uri_regex}{(character) request URI as regex. either this or \code{uri}
required}
}
\description{
StubbedRequest class
}
\details{
\strong{Methods}
\describe{
\item{\code{with(query, body, headers)}}{
Set expectations for what's given in HTTP request
\itemize{
\item query (list) request query params, as a named list. optional
\item body (list) request body, as a named list. optional
\item headers (list) request headers as a named list. optional.
}
}
\item{\code{to_return(status, body, headers)}}{
Set expectations for what's returned in HTTP resonse
\itemize{
\item status (numeric) an HTTP status code
\item body (list) response body, as a list. optional
\item headers (list) named list, response headers. optional.
}
}
\item{\code{to_s()}}{
Response as a string
}
}
}
\examples{
\dontrun{
x <- StubbedRequest$new(method = "get", uri = "api.crossref.org")
x$method
x$uri
x$with(headers = list('User-Agent' = 'R'))
x$to_return(status = 200, body = "foobar", headers = list(a = 5))
x
x$to_s()

# uri_regex
(x <- StubbedRequest$new(method = "get", uri_regex = ".+ossref.org"))
x$method
x$uri
x$to_s()
}
}
\seealso{
\code{\link[=stub_request]{stub_request()}}
}
\keyword{datasets}
