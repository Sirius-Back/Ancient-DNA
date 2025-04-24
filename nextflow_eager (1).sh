#!/bin/bash

#fastq=''
reference='/projects/ancient_dna/reference/GRCh37.p13.genome.fa'

# Path to your samples directory
SAMPLES_DIR="/home/abydanov/ancient/data/FN2"
OUTPUT_DIR="/home/abydanov/ancient/nf_eager_results"
NEXTFLOW_SCRIPT="eager"
PROFILE="conda"

# Check if output directory exists, if not create it
if [ ! -d "$OUTPUT_DIR" ]; then
  mkdir -p "$OUTPUT_DIR"
fi

# Loop through each sample directory and run nf-core/eager
for SAMPLE_DIR in "$SAMPLES_DIR"/*; do
  if [ -d "$SAMPLE_DIR" ]; then
    SAMPLE_NAME=$(basename "$SAMPLE_DIR")
    echo "Processing $SAMPLE_NAME..."

    nextflow run nf-core/$NEXTFLOW_SCRIPT \
      -profile $PROFILE \
      -name "project_kavkaz_040924" \
      --input "$SAMPLE_DIR/*.fastq.gz" \
      --outdir "$OUTPUT_DIR/$SAMPLE_NAME" \
      --fasta "$reference" \
      -w "$OUTPUT_DIR" \
      --preserve5p \
      --mergedonly \
      --dedupper 'dedup' \
      --bwaalnn 0.01 \
      --run_bam_filtering \
      --bam_mapping_quality_threshold 25 \
      --bam_unmapped_type 'discard' \
      --run_trim_bam \
      --run_sexdeterrmine \
      --sexdeterrmine_bedfile '/projects/ancient_dna/reference/1240K.pos.list_HG19.0based.bed' \
      --run_nuclear_contamination \
      --contamination_chrom_name 'X' \
      --run_mtnucratio \
      --mtnucratio_header 'MT' \
      --pileupcaller_bedfile '/projects/ancient_dna/reference/1240K.pos.list_HG19.0based.bed' \
      --pileupcaller_snpfile '/projects/ancient_dna/SNP_base/position.1240k.hg37.snp'

      #-with-report "$OUTPUT_DIR/$SAMPLE_NAME/report.html" \
      #-with-trace "$OUTPUT_DIR/$SAMPLE_NAME/trace.txt" \
      #-with-timeline "$OUTPUT_DIR/$SAMPLE_NAME/timeline.html" \
      #-with-dag "$OUTPUT_DIR/$SAMPLE_NAME/flowchart.png"

    echo "$SAMPLE_NAME done."
  fi
done

echo "All samples processed!"

