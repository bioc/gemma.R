% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/allEndpoints.R
\name{get_dataset_processed_expression}
\alias{get_dataset_processed_expression}
\title{Retrieve processed expression data of a dataset}
\usage{
get_dataset_processed_expression(
  dataset,
  raw = getOption("gemma.raw", FALSE),
  memoised = getOption("gemma.memoised", FALSE),
  file = getOption("gemma.file", NA_character_),
  overwrite = getOption("gemma.overwrite", FALSE)
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
results to a file. If \code{raw == TRUE}, the output will be the raw endpoint from the
API, likely a JSON or a gzip file. Otherwise, it will be a RDS file.}

\item{overwrite}{Whether or not to overwrite if a file exists at the specified
filename.}
}
\value{
If raw is FALSE (default), a data table of the expression matrix for
the queried dataset. If raw is TRUE, returns the binary file in raw form.
}
\description{
Retrieve processed expression data of a dataset
}
\examples{
get_dataset_processed_expression("GSE2018")
}
\keyword{dataset}
