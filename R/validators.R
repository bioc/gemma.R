compress_arg <- function(arg){
    temp <- tempfile()
    cat(arg,file = temp,sep = ',')
    R.utils::gzip(temp)
    compressed_arg <-  base64enc::base64encode(paste0(temp,'.gz'))
    unlink(paste0(temp,'.gz'))
    return(compressed_arg)
}


#' Validate identifiers (ie. gene ID, platform ID, etc.) that are homogeneous (either all numerics or all not)
#'
#' @param name The variable name
#' @param ... Any identifiers
#'
#' @return The validated identifiers, or stop with an error message
#'
#' @keywords internal
validateID <- function(name, ...) {
    ID <- unlist(list(...))
    isID <- grepl("^\\d+$", ID)

    if (any(is.na(ID)) || (any(isID) && !all(isID)) || any(ID == "")) {
        stop(glue::glue("Please specify valid identifiers for {name} and do not combine different types of identifiers."), call. = FALSE)
    }
    paste0(ID, collapse = ",")
}

#' Validate identifiers (ie. gene ID, platform ID, etc.) that are homogeneous (either all numerics or all not)
#'
#' @param name The variable name
#' @param ... Any identifiers
#'
#' @return The validated identifiers, or stop with an error message
#'
#' @keywords internal
validateOptionalID <- function(name, ...) {
    if (all(is.na(as.character(unlist(list(...)))))) {
        ""
    } else {
        validateID(name, ...)
    }
}

#' Validate a single identifier(ie. gene ID, platform ID, etc.)
#'
#' @param name The variable name
#' @param ... An identifier
#'
#' @return The validated identifier, or stop with an error message
#'
#' @keywords internal
validateSingleID <- function(name, ...) {
    ID <- unlist(list(...))

    if (length(ID) > 1) {
        stop(glue::glue("Please specify one valid identifier for {name}."), call. = FALSE)
    }
    validateID(name, ...)
}

#' Validate a taxon using the acceptable taxa entries
#'
#' @param name The variable name
#' @param ... Any taxa to validate
#'
#' @return The validated taxon, or stop with an error message
#'
#' @keywords internal
validateOptionalTaxon <- function(name, ...) {
    if (all(is.na(as.character(unlist(list(...)))))) {
        ""
    } else {
        validateTaxon(name, ...)
    }
}

#' Validate a taxon using the acceptable taxa entries
#'
#' @param name The variable name
#' @param ... Any taxa to validate
#'
#' @return The validated taxon, or stop with an error message
#'
#' @keywords internal
validateTaxon <- function(name, ...) {
    taxa <- as.character(unlist(list(...)))
    if (length(taxa) > 1) {
        stop("Please specify only one taxon.", call. = FALSE)
    }
    LOOKUP_TABLE <- data.table(
        id = c(1, 2, 3, 11, 12, 13, 14),
        name = c("human", "mouse", "rat", "yeast", "zebrafish", "fly", "worm"),
        scientific = c(
            "Homo sapiens", "Mus musculus", "Rattus norvegicus",
            "Saccharomyces cerevisiae", "Danio rerio", "Drosophila melanogaster",
            "Caenorhabditis elegans"
        ),
        ncbi = c(9606, 10090, 10116, 4932, 7955, 7227, 6239)
    )

    if (!all(taxa %in% c("", unlist(LOOKUP_TABLE)))) {
        stop("You must specify a valid taxon. The available taxa are:
            human, mouse, rat, yeast, zebrafish, fly and worm.",
            call. = FALSE)
    }
    paste0(taxa, collapse = ",")
}

#' Validate taxa using the acceptable taxa entries
#'
#' @param name The variable name
#' @param ... Any taxa to validate
#'
#' @return The validated taxa, or stop with an error message
#'
#' @keywords internal
validateTaxa <- function(name, ...){
    taxa <- as.character(unlist(list(...)))
    LOOKUP_TABLE <- data.table(
        id = c(1, 2, 3, 11, 12, 13, 14),
        name = c("human", "mouse", "rat", "yeast", "zebrafish", "fly", "worm"),
        scientific = c(
            "Homo sapiens", "Mus musculus", "Rattus norvegicus",
            "Saccharomyces cerevisiae", "Danio rerio", "Drosophila melanogaster",
            "Caenorhabditis elegans"
        ),
        ncbi = c(9606, 10090, 10116, 4932, 7955, 7227, 6239)
    )
    if (!all(taxa %in% c("", unlist(LOOKUP_TABLE)))) {
        stop("You must specify a valid taxon. The available taxa are:
            human, mouse, rat, yeast, zebrafish, fly and worm.",
             call. = FALSE)
    }
    paste0(taxa, collapse = ",")

}

#' Validate a query
#'
#' @param name The variable name
#' @param ... Any queries
#'
#' @return The validated queries, or stop with an error message
#'
#' @keywords internal
validateQuery <- function(name, ...) {
    query <- unlist(list(...))

    if (all(is.na(query)) || length(query) == 0) {
        stop(glue::glue("Please specify a query for {name}."), call. = FALSE)
    }

    paste0(query, collapse = ",")
}

#' Validate am optional query
#'
#' @param name The variable name
#' @param ... Any queries
#'
#' @return The validated queries
#'
#' @keywords internal
validateOptionalQuery <- function(name,...){
    if (all(is.na(as.character(unlist(list(...)))))) {
        ""
    } else {
        validateSingleQuery(name, ...)
    }
}

validateSingleQuery <- function(name,...){
    query <- unlist(list(...))
    if (all(is.na(query)) || length(query) == 0){
        stop(glue::glue("Please specify a query for {name}."), call. = FALSE)
    } else if(length(query)>1){
        stop(glue::glue("Please use a length one vector for {name}."), call. = FALSE)
    }
    
    query
}

#' Validate a non-negative integer value
#'
#' @param name The variable name
#' @param ... Any possible integers
#'
#' @return The validated integers, or stop with an error message
#'
#' @keywords internal
validatePositiveInteger <- function(name, ...) {
    args <- list(...)
    if (length(unlist(args)) != 1 || any(is.na(unlist(args))) ||
            !is.numeric(unlist(args)) ||
            any(vapply(args, "%%", 1, FUN.VALUE = numeric(1)) != 0) ||
            any(vapply(args, sign, FUN.VALUE = numeric(1)) < 0)) {
        stop(glue::glue("Please only specify positive integer values for {name}."),
            call. = FALSE)
    }
    unlist(args)
}

#' Validate a limit value
#'
#' @param name The variable name
#' @param ... Any possible integers
#'
#' @return The validated integers, or stop with an error message
#'
#' @keywords internal
validateLimit <- function(name, ...) {
    validatePositiveInteger(name, ...)
    args <- list(...)
    if (unlist(args) <= 0 || unlist(args) > 100) {
        stop(glue::glue("Please specify a limit between 1 and 100 (inclusive)"),
            call. = FALSE)
    }
    unlist(args)
}

#' Validate a boolean value
#'
#' @param name The variable name
#' @param ... Any boolean types
#'
#' @return The validated boolean as a character string (true or false), or stop with an error message
#'
#' @keywords internal
validateBoolean <- function(name, ...) {
    args <- unlist(list(...))
    if (length(args) != 1 || !is.logical(args)) {
        stop(glue::glue("Please only specify boolean values for {name}."),
            call. = FALSE)
    }
    tolower(as.character(args))
}

#' Validate a sort argument
#'
#' @param name The variable name
#' @param ... Any sort arguments
#'
#' @return The validated sort arguments, or stop with an error message
#'
#' @keywords internal
validateSort <- function(name, ...) {
    sort <- unlist(list(...))
    if (length(sort) != 1 || !all(grepl("^[+-].+", sort))) {
        stop("Sort must match [+,-][property name].", call. = FALSE)
    }
    sort
}




#' Validate result types
#'
#' @param name The variable name
#' @param ... result types
#' @return Validated result types. Either returned as they are or they will be
#' replaced from human readable variants
#' @keywords internal
validateResultType <- function(name,...){
    type <- unlist(list(...))
    if (length(type)>1){
        stop('Must provide only one result type.')
    }
    type <- switch (type,
                   experiment = "ubic.gemma.model.expression.experiment.ExpressionExperiment",
                   gene = "ubic.gemma.model.genome.Gene",
                   platform = 'ubic.gemma.model.expression.arrayDesign.ArrayDesign',
                   type
    )

    return(type)
}


validateConsolidate <- function(name, ...){
    consolidate <- unlist(list(...))
    if(length(consolidate)>1 | (!consolidate %in% c(NA_character_,'pickmax','pickvar','average'))){
        stop('consolidate must be NA, "pickmax", "pickmax" or "average"')
    }
    return(consolidate)
}


validateFilter <- function(name, ...){
    
    filter <-  unlist(list(...))
    assertthat::assert_that(is.null(filter) || is.na(filter) || assertthat::is.string(filter),msg = "filter must be a string of length one")
    
    if(is.null(filter) || is.na(filter)){
        filter <- ''
    }
    
    # filter has a few helper arguments that it can borrow from
    env <- parent.frame()
    
    if (!(all(is.na(env$original_env$taxa))||is.null(env$original_env$taxa))){
        filter <- addToFilter(filter,"taxon.commonName",env$original_env$taxa)
    }
    if (!(all(is.na(env$original_env$uris))||is.null(env$original_env$uris))){
        filter <- addToFilter(filter,"allCharacteristics.valueUri",env$original_env$uris)
    }
    
   if (!(all(is.na(env$original_env$resultSets))||is.null(env$original_env$resultSets)) && env$fname == 'get_result_sets'){
        filter <- addToFilter(filter,"id",env$original_env$resultSets)
    }    
    
    return(filter)
}

addToFilter <- function(filter,property,terms){
    
    if(nchar(filter) > 0){
        filter <- paste0(filter,' and ')
    }
    
    filter <- glue::glue("{filter}{property} in ({paste(terms,collapse = ',')})")
    return(filter)
}

validateNumber = function(name,...){
    number = unlist(list(...))
    
    if(length(number)>1 || typeof(number)!= 'double'){
        stop(glue::glue("{name} must be a double of length one"))
    }
    
    return(number)
}
