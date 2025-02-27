#!/bin/bash
# Script: run_multiqc.sh
# Description: Runs MultiQC on FastQC reports

# Set strict error handling
set -euo pipefail

# Function to display usage
usage() {
    echo "Usage: bash run_multiqc.sh <path_to_fastqc_reports_directory>"
    echo "Options:"
    echo "  path_to_fastqc_reports_directory  Directory containing FastQC reports"
    exit 1
}

# Ensure MultiQC is installed
if ! command -v multiqc &> /dev/null; then
    echo "Error: MultiQC is not installed. Please install MultiQC before running this script."
    exit 1
fi

# Check command line arguments
[ $# -ne 1 ] && usage

INPUT_DIR=$1
OUTPUT_DIR="results/multiqc_report"
LOG_DIR="$OUTPUT_DIR/logs"

# Create output and log directories
mkdir -p "$OUTPUT_DIR" "$LOG_DIR"

# Get current timestamp
TIMESTAMP=$(date "+%Y%m%d_%H%M%S")

echo "=== MultiQC Analysis Started at $(date) ==="
echo "Input directory: $INPUT_DIR"
echo "Output directory: $OUTPUT_DIR"

# Run MultiQC
multiqc "$INPUT_DIR" -o "$OUTPUT_DIR" 2>"$LOG_DIR/multiqc_${TIMESTAMP}.log"

if [ $? -eq 0 ]; then
    echo "=== MultiQC analysis completed successfully ==="
    echo "Report saved in: $OUTPUT_DIR"
    echo "Log file: $LOG_DIR/multiqc_${TIMESTAMP}.log"
else
    echo "Error: MultiQC analysis failed. Check log file for details."
    exit 1
fi

exit 0
