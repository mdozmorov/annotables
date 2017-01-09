for file in `find . -type f -name "*.bed"`; do echo $file; bedtools sort -i $file > tmp.bed && mv tmp.bed $file; done

# http://www.ensembl.org/Help/Faq?id=468

mkdir -p protein_coding
cp protein_coding.bed protein_coding/
cp IG_C_gene.bed IG_D_gene.bed IG_J_gene.bed IG_V_gene.bed protein_coding/
cat IG_C_gene.bed IG_D_gene.bed IG_J_gene.bed IG_V_gene.bed | bedtools sort -i - > protein_coding/IG_all_gene.bed
cp polymorphic_pseudogene.bed protein_coding/
cp TR_C_gene.bed TR_D_gene.bed TR_J_gene.bed TR_V_gene.bed protein_coding/
cat TR_C_gene.bed TR_D_gene.bed TR_J_gene.bed TR_V_gene.bed | bedtools sort -i - > protein_coding/TR_all_gene.bed
cat protein_coding/*.bed | bedtools sort -i - > protein_coding/all_protein_coding.bed

mkdir -p pseudogene
cp pseudogene.bed pseudogene/
cp IG_C_pseudogene.bed IG_J_pseudogene.bed IG_V_pseudogene.bed pseudogene/
cat IG_C_pseudogene.bed IG_J_pseudogene.bed IG_V_pseudogene.bed | bedtools sort -i - > pseudogene/IG_all_pseudogene.bed
cp TR_J_pseudogene.bed TR_V_pseudogene.bed pseudogene/
cat TR_J_pseudogene.bed TR_V_pseudogene.bed | bedtools sort -i - > pseudogene/TR_all_pseudogene.bed
cat pseudogene/*.bed | bedtools sort -i > pseudogene/all_pseudogene.bed

mkdir -p long_noncoding
cp 3prime_overlapping_ncrna.bed antisense.bed lincRNA.bed processed_transcript.bed sense_intronic.bed sense_overlapping.bed long_noncoding/
cat long_noncoding/*.bed | bedtools sort -i - > long_noncoding/all_long_noncoding.bed

mkdir -p short_noncoding
cp miRNA.bed misc_RNA.bed Mt_rRNA.bed Mt_tRNA.bed rRNA.bed snRNA.bed snoRNA.bed short_noncoding/
cat short_noncoding/*.bed | bedtools sort -i - > short_noncoding/all_short_noncoding.bed

