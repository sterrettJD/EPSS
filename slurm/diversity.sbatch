#!/bin/bash
#SBATCH -p short # Partition or queue.
#SBATCH --job-name=diversity # Job name
#SBATCH --mail-type=ALL # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=jost9358@colorado.edu
#SBATCH --nodes=1 # Only use a single node
#SBATCH --ntasks=32 # Run on a single CPU
#SBATCH --mem=32gb # Memory limit
#SBATCH --time=10:00:00 # Time limit hrs:min:sec
#SBATCH --output=/scratch/Users/jost9358/EPSS/slurm_outs/diversity_%j.out # Standard output and error log
#SBATCH --error=/scratch/Users/jost9358/EPSS/slurm_outs/diversity_%j.err # %j inserts job number

source activate qiime2-2021.4

qiime diversity alpha-rarefaction \
--i-table EPSS_noMito_noChloro-filtered-table.qza \
--i-phylogeny EPSS_insertion-tree-sepp.qza \
--o-visualization EPSS_rarefied-viz.qzv \
--p-max-depth 54000

qiime diversity core-metrics-phylogenetic \
--i-phylogeny EPSS_insertion-tree-sepp.qza \
--i-table EPSS_noMito_noChloro-filtered-table.qza \
--p-sampling-depth 18000 \
--m-metadata-file metadata.txt \
--output-dir EPSS_core-diversity-results

qiime taxa barplot \
--i-table EPSS_core-diversity-results/rarefied_table.qza \
--m-metadata-file metadata.txt \
--i-taxonomy EPSS_silva-classified/classification.qza \
--o-visualization EPSS_taxa_plot_post_rarefaction.qzv
