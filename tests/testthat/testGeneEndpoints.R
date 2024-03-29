test_that("getGenesInfo queries work", {
    dat <- get_genes(1859)
    raw <- get_genes(1859, raw = TRUE) %>% jsonlite:::simplify()
    expect_type(dat, "list")
    expect_type(raw, "list")
    expect_equal(
        dat[, c(gene.symbol, gene.ensembl, gene.name, taxon.name)],
        c(raw$officialSymbol, raw$ensemblId, raw$officialName, raw$taxon$commonName)
    )
})

test_that("getGeneLocation queries work", {
    dat <- get_gene_locations(1859)
    raw <- get_gene_locations(1859, raw = TRUE) %>% jsonlite:::simplify()
    expect_type(dat, "list")
    expect_type(raw, "list")
    expect_equal(
        dat[, c(chromosome, strand, nucleotide, length)],
        c(raw$chromosome, raw$strand, raw$nucleotide, raw$nucleotideLength)
    )
})

test_that("getGeneProbes queries work", {
    dat <- get_gene_probes(1859)
    raw <- get_gene_probes(1859, raw = TRUE) %>% jsonlite:::simplify()
    expect_type(dat, "list")
    expect_type(raw, "list")
    expect_equal(
        dat[, c(mapping.name, mapping.description)],
        c(raw$name, raw$description)
    )
    expect_equal(get_gene_probes(1859, limit = 10) %>% nrow(), 10)
})

test_that('searchAnnotations work',{
    annots = search_annotations("traumatic")
    expect_s3_class(annots,'data.table')
    expect_true(all(names(annots) %in% c("category.name", "category.URI", "value.name", "value.URI")))
})

#test_that("getGeneGO queries work", {
    # dat <- get_gene_go_terms(1859)
    # raw <- get_gene_go_terms(1859, raw = TRUE) %>% jsonlite:::simplify()
    # expect_type(dat, "list")
    # expect_type(raw, "list")
    # expect_equal(
    #     dat[, c(term.Name, term.ID, term.URI)],
    #     c(raw$term, raw$goId, raw$uri)
    #)
#})
