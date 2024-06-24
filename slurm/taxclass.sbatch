#!/bin/bash
#SBATCH -p short # Partition or queue.
#SBATCH --job-name=taxclass # Job name
#SBATCH --mail-type=ALL # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=jost9358@colorado.edu
#SBATCH --nodes=1 # Only use a single node
#SBATCH --ntasks=1 # Run on a single CPU
#SBATCH --mem=16gb # Memory limit
#SBATCH --time=6:00:00 # Time limit hrs:min:sec
#SBATCH --output=/scratch/Users/jost9358/EPSS/slurm_outs/taxclass_%j.out # Standard output and error log
#SBATCH --error=/scratch/Users/jost9358/EPSS/slurm_outs/taxclass_%j.err # %j inserts job number

source activate qiime2-2021.4

qiime feature-classifier classify-sklearn \
--i-classifier ../silva-138-99-515-806-nb-classifier.qza \
--i-reads EPSS_dada2-results/representative_sequences.qza \
--output-dir EPSS_silva-classified

qiime metadata tabulate \
--m-input-file EPSS_silva-classified/classification.qza \
--o-visualization EPSS_silva-classified/classification.qzv

qiime taxa filter-table \
--i-table EPSS_filtered-table-sepp.qza \
--i-taxonomy EPSS_silva-classified/classification.qza \
--p-exclude mitochondria,chloroplast \
--o-filtered-table EPSS_noMito_noChloro-filtered-table.qza

qiime feature-table summarize \
--i-table EPSS_noMito_noChloro-filtered-table.qza \
--o-visualization EPSS_noMito_noChloro-filtered-table.qzv

qiime taxa barplot \
--i-table EPSS_noMito_noChloro-filtered-table.qza \
--i-taxonomy EPSS_silva-classified/classification.qza \
--m-metadata-file metadata.txt \
--o-visualization EPSS_taxa_plot.qzv