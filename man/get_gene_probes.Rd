% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/allEndpoints.R
\name{get_gene_probes}
\alias{get_gene_probes}
\title{Retrieve the probes associated to a genes across all platforms}
\usage{
get_gene_probes(
  gene,
  offset = 0L,
  limit = 20L,
  raw = getOption("gemma.raw", FALSE),
  memoised = getOption("gemma.memoised", FALSE),
  file = getOption("gemma.file", NA_character_),
  overwrite = getOption("gemma.overwrite", FALSE)
)
}
\arguments{
\item{gene}{An ensembl gene identifier which typically starts with ensg or an ncbi gene identifier or an official gene symbol approved by hgnc}

\item{offset}{The offset of the first retrieved result.}

\item{limit}{Defaults to 20. Limits the result to specified amount
of objects. Has a maximum value of 100. Use together with \code{offset} and
the \code{totalElements} \link[base:attributes]{attribute} in the output to
compile all data if needed.}

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
A data table with information about the probes representing a gene across
all platrofms. A list if \code{raw = TRUE}.
A \code{404 error} if the given identifier does not map to any genes.

The fields of the output data.table are:

\itemize{
\item \code{element.name}: Name of the element. Typically the probeset name
\item \code{element.description}: A free text field providing optional information about the element
\item \code{platform.shortName}: Shortname of the platform given by Gemma. Typically the GPL identifier.
\item \code{platform.name}: Full name of the platform
\item \code{platform.ID}: Id number of the platform given by Gemma
\item \code{platform.type}: Type of the platform.
\item \code{platform.description}: Free text field describing the platform.
\item \code{platform.troubled}: Whether the platform is marked as troubled by a Gemma curator.
\item \code{taxon.name}: Name of the species platform was made for
\item \code{taxon.scientific}: Scientific name for the taxon
\item \code{taxon.ID}: Internal identifier given to the species by Gemma
\item \code{taxon.NCBI}: NCBI ID of the taxon
\item \code{taxon.database.name}: Underlying database used in Gemma for the taxon
\item \code{taxon.database.ID}: ID of the underyling database used in Gemma for the taxon
}
}
\description{
Retrieve the probes associated to a genes across all platforms
}
\examples{
get_gene_probes(1859)
}
\keyword{gene}
