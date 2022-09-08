% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/allEndpoints.R
\name{get_dataset_design}
\alias{get_dataset_design}
\title{Get dataset design}
\usage{
get_dataset_design(
  dataset,
  raw = getOption("gemma.raw", FALSE),
  memoised = getOption("gemma.memoised", FALSE),
  file = getOption("gemma.file", NA_character_),
  overwrite = getOption("gemma.overwrite", FALSE),
  attributes = getOption("gemma.attributes", TRUE)
)
}
\arguments{
\item{dataset}{A numerical dataset identifier or a dataset short name}

\item{raw}{\code{TRUE} to receive results as-is from Gemma, or \code{FALSE} to enable
parsing. Raw results usually contain additional fields and flags that are
omitted in the parsed results.}

\item{memoised}{Whether or not to save to cache for future calls with the
same inputs and use the result saved in cache if a result is already saved.
Doing \code{options(gemma.memoised = TRUE)} will ensure that the cache is always
used. Use \code{\link{forget_gemma_memoised}} to clear the cache.}

\item{file}{The name of a file to save the results to, or \code{NULL} to not write
results to a file. If \code{raw == TRUE}, the output will be a JSON file. Otherwise,
it will be a RDS file.}

\item{overwrite}{Whether or not to overwrite if a file exists at the specified
filename.}

\item{attributes}{If \code{TRUE} additional information from the call will be added
into the output object's attributes such as offset and available elements.}
}
\value{
A data table of the design matrix for the queried dataset.
A \code{404 error} if the given identifier does not map to any object
}
\description{
Retrieve the design of a dataset
}
\examples{
head(get_dataset_design("GSE2018"))
}
\keyword{dataset}