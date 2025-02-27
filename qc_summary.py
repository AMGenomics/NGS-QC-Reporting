#!/usr/bin/env python3
"""
Script: qc_summary.py
Description: Extracts and summarizes QC metrics from FastQC reports
"""

import os
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

# Function to extract FastQC summary data
def get_fastqc_data(input_dir):
    summary_data = []
    for root, _, files in os.walk(input_dir):
        for file in files:
            if file.endswith("summary.txt"):
                filepath = os.path.join(root, file)
                with open(filepath, "r") as f:
                    for line in f:
                        status, test, filename = line.strip().split('\t')
                        summary_data.append([filename, test, status])
    return pd.DataFrame(summary_data, columns=["Filename", "Test", "Status"])

# Function to generate a summary CSV report
def generate_qc_summary(input_dir, output_csv):
    df = get_fastqc_data(input_dir)
    df.to_csv(output_csv, index=False)
    print(f"QC summary saved to {output_csv}")

# Function to plot QC statistics
def plot_qc_summary(df, output_img):
    plt.figure(figsize=(10, 6))
    sns.countplot(data=df, x="Test", hue="Status", palette="coolwarm")
    plt.xticks(rotation=90)
    plt.title("FastQC Summary Statistics")
    plt.xlabel("QC Test")
    plt.ylabel("Count")
    plt.legend(title="Status")
    plt.tight_layout()
    plt.savefig(output_img)
    print(f"QC plot saved to {output_img}")

if __name__ == "__main__":
    import argparse
    parser = argparse.ArgumentParser(description="Summarize FastQC reports and generate plots.")
    parser.add_argument("input_dir", help="Path to directory containing FastQC reports")
    parser.add_argument("output_csv", help="Path to save QC summary CSV")
    parser.add_argument("output_img", help="Path to save QC summary plot")
    args = parser.parse_args()
    
    df = get_fastqc_data(args.input_dir)
    generate_qc_summary(args.input_dir, args.output_csv)
    plot_qc_summary(df, args.output_img)
