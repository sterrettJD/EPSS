#!/bin/bash
#SBATCH -p short # Partition or queue.
#SBATCH --job-name=dada2 # Job name
#SBATCH --mail-type=ALL # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=jost9358@colorado.edu
#SBATCH --nodes=1 # Only use a single node
#SBATCH --ntasks=32 # Run on a single CPU
#SBATCH --mem=32gb # Memory limit
#SBATCH --time=10:00:00 # Time limit hrs:min:sec
#SBATCH --output=/scratch/Users/jost9358/EPSS/slurm_outs/dada2_%j.out # Standard output and error log
#SBATCH --error=/scratch/Users/jost9358/EPSS/slurm_outs/dada2_%j.err # %j inserts job number

source activate qiime2-2021.4

qiime dada2 denoise-paired \
--i-demultiplexed-seqs EPSS_demux/per_sample_sequences.qza \
--p-trunc-len-f 151 --p-trunc-len-r 151 \
--p-trim-left-f 19 --p-trim-left-r 19 \
--p-n-threads 32 \
--output-dir EPSS_dada2-results \
--verbose

qiime metadata tabulate \
--m-input-file EPSS_dada2-results/denoising_stats.qza \
--o-visualization EPSS_dada2-results/denoising_stats.qzv

qiime feature-table filter-samples \
--i-table EPSS_dada2-results/table.qza \
--m-metadata-file metadata.txt \
--o-filtered-table EPSS_filtered_table.qza

qiime feature-table summarize \
--i-table EPSS_dada2-results/table.qza \
--o-visualization EPSS_dada2-results/table.qzv \
--m-sample-metadata-file metadata.txt
