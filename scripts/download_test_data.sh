#!/bin/bash
# Script: download_test_data.sh
# Description: Downloads a small public FASTQ dataset from NCBI SRA

# Create the data directory if it doesn't exist
mkdir -p data

# Download a small FASTQ test file from EBI-ENA (NCBI SRA mirror)
echo "Downloading sample FASTQ data from NCBI SRA..."
wget -O data/sample.fastq.gz \
    ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR835/SRR835775/SRR835775.fastq.gz

echo "Download complete! Sample FASTQ saved in data/sample.fastq.gz"
