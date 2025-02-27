#!/bin/bash
# Script: run_fastqc.sh
# Description: Runs FastQC on all FASTQ files in the specified directory

# Set strict error handling
set -euo pipefail

# Function to display usage
usage() {
    echo "Usage: bash run_fastqc.sh <path_to_fastq_directory> [number_of_threads]"
    echo "Options:"
    echo "  path_to_fastq_directory  Directory containing FASTQ files"
    echo "  number_of_threads        Number of threads to use (default: 4)"
    exit 1
}

# Function to check if directory exists and contains FASTQ files
check_input_dir() {
    local dir=$1
    if [ ! -d "$dir" ]; then
        echo "Error: Directory '$dir' does not exist"
        exit 1
    fi
    
    if ! ls $dir/*.fastq.gz &> /dev/null && ! ls $dir/*.fq.gz &> /dev/null; then
        echo "Error: No FASTQ files found in '$dir'"
        exit 1
    fi
}

# Ensure FastQC is installed
if ! command -v fastqc &> /dev/null; then
    echo "Error: FastQC is not installed. Please install FastQC before running this script."
    exit 1
fi

# Check command line arguments
[ $# -lt 1 ] && usage

INPUT_DIR=$1
THREADS=${2:-4}  # Default to 4 threads if not specified
OUTPUT_DIR="results/fastqc_reports"
LOG_DIR="$OUTPUT_DIR/logs"

# Check input directory
check_input_dir "$INPUT_DIR"

# Create output and log directories
mkdir -p "$OUTPUT_DIR" "$LOG_DIR"

# Get current timestamp
TIMESTAMP=$(date "+%Y%m%d_%H%M%S")

echo "=== FastQC Analysis Started at $(date) ==="
echo "Input directory: $INPUT_DIR"
echo "Output directory: $OUTPUT_DIR"
echo "Using $THREADS threads"

# Run FastQC on all FASTQ files
echo "Running FastQC on FASTQ files..."
fastqc \
    --threads "$THREADS" \
    --noextract \
    --outdir "$OUTPUT_DIR" \
    $INPUT_DIR/*.fastq.gz $INPUT_DIR/*.fq.gz 2>"$LOG_DIR/fastqc_${TIMESTAMP}.log"

# Check if FastQC completed successfully
if [ $? -eq 0 ]; then
    echo "=== FastQC analysis completed successfully ==="
    echo "Results saved in: $OUTPUT_DIR"
    echo "Log file: $LOG_DIR/fastqc_${TIMESTAMP}.log"
else
    echo "Error: FastQC analysis failed. Check log file for details."
    echo "Log file: $LOG_DIR/fastqc_${TIMESTAMP}.log"
    exit 1
fi

# Print summary of processed files
echo -e "\nProcessed files:"
ls -1 "$OUTPUT_DIR"/*_fastqc.html | wc -l

exit 0
