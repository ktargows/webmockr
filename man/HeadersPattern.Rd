% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/RequestPattern.R
\docType{data}
\name{HeadersPattern}
\alias{HeadersPattern}
\title{HeadersPattern}
\arguments{
\item{pattern}{(list) a pattern, as a named list, must be named,
e.g,. \code{list(a = 5, b = 6)}}
}
\description{
HeadersPattern
}
\details{
\strong{Methods}
\describe{
\item{\code{matches(headers)}}{
Match a list of headers against that stored
- headers (list) named list of headers, e.g,. \code{list(a = 5, b = 6)}
}
}

\code{webmockr} normalises headers and treats all forms of same headers as equal:
i.e the following two sets of headers are equal:
\code{list(Header1 = "value1", content_length = 123, X_CuStOm_hEAder = "foo")}
and
\code{list(header1 = "value1", "Content-Length" = 123, "x-cuSTOM-HeAder" = "foo")}
}
\examples{
(x <- HeadersPattern$new(pattern = list(a = 5)))
x$pattern
x$matches(list(a = 5))

# different cases
(x <- HeadersPattern$new(pattern = list(Header1 = "value1")))
x$pattern
x$matches(list(header1 = "value1"))
x$matches(list(header1 = "value2"))

# different symbols
(x <- HeadersPattern$new(pattern = list(`Hello_World` = "yep")))
x$pattern
x$matches(list(`hello-world` = "yep"))
x$matches(list(`hello-worlds` = "yep"))
}
\keyword{internal}
