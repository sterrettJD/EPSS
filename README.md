# Effects of Pets on Social Stress Study (microbiome analysis)

This repository contains code for reproducing analyses found in the manuscript "Daily pet contact during urban upbringing improves immunoregulatory and barrier functions and ameliorates the inflammatory stress-response in adulthood".

## Data processing
16s V4 sequencing data were processed using QIIME2, for which details can be found in the quarto markdown document `analysis/Processing.qmd`.

## Statistical analysis
Statistical analysis and visualization of community diversity metrics, as well as visualization of taxonomic composition, were performed in R and can be found in the quarto markdown document `analysis/Analysis.qmd`.

## Slurm batch jobs
The directory `slurm/` contains `.sbatch` scripts used to run these jobs on a Slurm-managed compute cluster.

