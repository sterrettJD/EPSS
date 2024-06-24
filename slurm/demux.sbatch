#!/bin/bash
#SBATCH -p short # Partition or queue.
#SBATCH --job-name=demux # Job name
#SBATCH --mail-type=ALL # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=jost9358@colorado.edu
#SBATCH --nodes=1 # Only use a single node
#SBATCH --ntasks=1 # Run on a single CPU
#SBATCH --mem=16gb # Memory limit
#SBATCH --time=8:00:00 # Time limit hrs:min:sec
#SBATCH --output=/scratch/Users/jost9358/EPSS/slurm_outs/demux_%j.out # Standard output and error log
#SBATCH --error=/scratch/Users/jost9358/EPSS/slurm_outs/demux_%j.err # %j inserts job number

source activate qiime2-2021.4

qiime demux emp-paired \
--m-barcodes-file metadata.txt \
--m-barcodes-column 'Golay Barcode' \
--i-seqs ../import/paired-end-sequences.qza \
--p-rev-comp-barcodes \
--p-rev-comp-mapping-barcodes \
--output-dir EPSS_demux

qiime demux summarize --i-data EPSS_demux/per_sample_sequences.qza --o-visualization EPSS_demux/demux.qzv