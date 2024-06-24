#!/bin/bash
#SBATCH -p short # Partition or queue.
#SBATCH --job-name=sepp # Job name
#SBATCH --mail-type=ALL # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=jost9358@colorado.edu
#SBATCH --nodes=1 # Only use a single node
#SBATCH --ntasks=32 # Run on a single CPU
#SBATCH --mem=32gb # Memory limit
#SBATCH --time=10:00:00 # Time limit hrs:min:sec
#SBATCH --output=/scratch/Users/jost9358/EPSS/slurm_outs/sepp_%j.out # Standard output and error log
#SBATCH --error=/scratch/Users/jost9358/EPSS/slurm_outs/sepp_%j.err # %j inserts job number

source activate qiime2-2021.4

qiime fragment-insertion sepp \
--i-representative-sequences EPSS_dada2-results/representative_sequences.qza \
--i-reference-database ../sepp-refs-silva-128.qza \
--o-tree EPSS_insertion-tree-sepp.qza \
--o-placements EPSS_insertion-placements-sep.qza \
--p-threads 32

qiime fragment-insertion filter-features \
--i-table EPSS_filtered_table.qza \
--i-tree EPSS_insertion-tree-sepp.qza \
--o-filtered-table EPSS_filtered-table-sepp.qza \
--o-removed-table EPSS_removed-table-sepp.qza
