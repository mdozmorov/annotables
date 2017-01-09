library(biomaRt)
library(dplyr)

fix_genes <- . %>%
  tbl_df %>%
  distinct %>%
  rename(ensgene=ensembl_gene_id,
         entrez=entrezgene,
         symbol=mgi_symbol,
         chr=chromosome_name,
         start=start_position,
         end=end_position,
         biotype=gene_biotype)

myattributes <- c("ensembl_gene_id",
                  "entrezgene",
                  "mgi_symbol",
                  "chromosome_name",
                  "start_position",
                  "end_position",
                  "strand",
                  "gene_biotype",
                  "description")

# Mouse
# Archived biomart version for mm9
mmu9 <- useMart(host='may2009.archive.ensembl.org', biomart='ENSEMBL_MART_ENSEMBL', dataset="mmusculus_gene_ensembl") %>%
  useDataset(mart=., dataset="mmusculus_gene_ensembl") %>%
  getBM(mart=., attributes=myattributes) %>%
  fix_genes
devtools::use_data(mmu9)
