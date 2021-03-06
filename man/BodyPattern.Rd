% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/RequestPattern.R
\docType{data}
\name{BodyPattern}
\alias{BodyPattern}
\title{BodyPattern}
\arguments{
\item{pattern}{(list) a body object}
}
\description{
BodyPattern
}
\details{
\strong{Methods}
\describe{
\item{\code{matches(body, content_type = "")}}{
Match a body object against that given in \code{pattern}
- body (list) the body
- content_type (character) content type
}
}
}
\examples{
z <- BodyPattern$new(pattern = list(a = "foobar"))
z$pattern
}
\keyword{internal}
