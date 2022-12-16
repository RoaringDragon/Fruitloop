#!/bin/bash -l

module load bioinfo-tools Nextflow/20.10.0 bwa-mem2/2.2.1-20211213-edc703f samtools/1.14 #picard/2.27.5 GATK/4.3.0.0 snpEff/4.3t

export NXF_HOME="/proj/snic2022-23-502/private/Fruitloop/Code/Pipeline"

nextflow run main.nf --inputreads '/proj/snic2022-23-502/private/Fruitloop/Data/Trimmed/test'\
 --refgenome "/proj/snic2022-23-502/private/Fruitloop/Data/Sequences/Reference/GCF_000003195.3_Sorghum_bicolor_NCBIv3_genomic.fna.gz"\
 --outdir "/proj/snic2022-23-502/private/Fruitloop/Res/Pipeline/test/"\
 -c nextflow.config -profile uppmax --project "snic2022-22-1048" --clusterOptions "-M rackham" -resume



