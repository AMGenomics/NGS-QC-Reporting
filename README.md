# 📊 NGS Quality Control & Reporting

## 📌 Project Overview  
This project focuses on **quality control (QC) for next-generation sequencing (NGS) data** using **FastQC and MultiQC**. Ensuring high-quality sequencing reads is a critical first step before performing downstream analysis such as alignment and variant calling.

## 🔹 Objectives  
✔ Perform **quality control checks** on raw FASTQ files using **FastQC**  
✔ Aggregate multiple FastQC reports using **MultiQC**  
✔ Generate summary statistics and visualizations using **Python (pandas, Matplotlib, Seaborn)**  
✔ Provide a **Bash script** for automated QC processing  
✔ Define **quality score thresholds** for evaluation  
✔ Offer a **troubleshooting guide** for common issues  

## 🛠 Tools & Technologies  
- **FastQC** – Per-sample sequencing quality checks  
- **MultiQC** – Aggregate QC reports for multiple samples  
- **Python (pandas, Matplotlib, Seaborn)** – Generate summary statistics & plots  
- **Bash scripting** – Automate QC report generation  

## 📂 Folder Structure  
```bash
NGS-QC-Reporting/
│── README.md             # Project documentation
│── data/                 # Example FASTQ files (simulated or small test data)
│── results/              # Output QC reports (FastQC, MultiQC, Python summaries)
│── scripts/              # Bash & Python scripts for automation
│   ├── run_fastqc.sh     # Run FastQC on all FASTQ files
│   ├── run_multiqc.sh    # Generate MultiQC summary report
│   ├── qc_summary.py     # Python script to extract key QC metrics
│── notebooks/            # Jupyter Notebooks for analysis
│── docs/                 # Additional resources & references
```

## 🔹 How to Run This Project  
### **1️⃣ Install Dependencies**  
Ensure you have **FastQC**, **MultiQC**, and Python installed. Install required Python libraries:  
```bash
pip install pandas matplotlib seaborn
```

### **2️⃣ Run FastQC on Raw Reads**  
Use the Bash script to run **FastQC** on all FASTQ files in the `data/` folder:  
```bash
bash scripts/run_fastqc.sh data/
```

### **3️⃣ Aggregate QC Reports with MultiQC**  
After running FastQC, generate a **MultiQC** report:  
```bash
bash scripts/run_multiqc.sh results/
```

### **4️⃣ Summarize Key Metrics (Python Script)**  
Extract **GC content, sequence length distribution, and quality scores** from FastQC reports:  
```bash
python scripts/qc_summary.py results/
```

## 📊 Example Outputs  
- **FastQC Reports** (HTML files for each FASTQ sample)  
- **MultiQC Summary** (Aggregated QC report in HTML format)  
- **Python Plots** (Quality score distribution, GC content, read length histograms)  

## 📋 QC Metrics & Thresholds  
### Quality Score Thresholds  
- **Good Quality**: Phred score > 30 (99.9% base call accuracy)  
- **Acceptable**: Phred score 20-30 (99% base call accuracy)  
- **Poor Quality**: Phred score < 20 (requires attention)  

### Key QC Parameters  
| Metric | Good | Warning | Fail |
|--------|------|---------|------|
| Per base sequence quality | >28 | 20-28 | <20 |
| GC Content | ±5% of expected | ±10% of expected | >±10% of expected |
| Sequence Duplication | <20% | 20-50% | >50% |
| Overrepresented sequences | <1% | 1-20% | >20% |
| Adapter Content | <5% | 5-10% | >10% |

## 🔧 Troubleshooting Guide  
### Common Issues & Solutions  
#### 1. FastQC Permission Errors  
```bash
Error: Cannot create output folder
Solution: Check folder permissions with:
chmod 755 results/
```

#### 2. MultiQC Report Generation Fails  
```bash
# If MultiQC fails to find input files:
# Check file paths and FastQC completion
ls -l results/*_fastqc.zip
# Ensure FastQC finished successfully
```

#### 3. Python Script Errors  
- **Missing Libraries**: Run `pip install -r requirements.txt`
- **Memory Issues**: Reduce batch size in `qc_summary.py`
- **File Not Found**: Verify FastQC output paths  

#### 4. Low Quality Scores  
- Check for degraded input material  
- Verify sequencing run parameters  
- Consider trimming low-quality bases:  
```bash
trimmomatic PE input_R1.fastq input_R2.fastq \
    output_R1_paired.fq output_R1_unpaired.fq \
    output_R2_paired.fq output_R2_unpaired.fq \
    TRAILING:20 MINLEN:50
```
## 📥 Download Public FASTQ Data
If you don't have sample data, run:
```bash
bash scripts/download_test_data.sh
```
## 🔍 Potential Extensions  
If expanded, this project could integrate:  
- **Automated QC summary reporting** (Markdown/PDF output).  
- **Machine learning models** to predict low-quality reads.  
- **Workflow automation** using **Nextflow/Snakemake** for large-scale data processing.
