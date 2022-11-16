#!/usr/bin/env nextflow

raw_reads='/proj/snic2022-23-502/private/Fruitloop/Data/Sequences/testuppsala/'
out_dir_trimmed='/proj/snic2022-23-502/private/Fruitloop/Data/Trimmed/testuppsala'
out_dir_qc='/proj/snic2022-23-502/private/Fruitloop/Res/QualityControll/testuppsala'

read_pair = Channel.fromFilePairs( "${raw_reads}/*R[1,2]*", type: 'file')


process runFastP {
        cpus { 8 }
        publishDir "${out_dir_trimmed}/", mode: 'copy', overwrite: false
        input:
                set sample, file(in_fastq) from read_pair

        output:
                file("trimmed_files/${sample}_trimmed_*.gz") into trimmed_channel
                file("report_files/${sample}*.json") into json_report
        """
        module load fastp/0.23.2
        mkdir trimmed_files
        mkdir report_files
        fastp \
        -i ${in_fastq.get(0)} -I ${in_fastq.get(1)} \
        -o trimmed_files/${sample}_trimmed_R1.fq.gz -O trimmed_files/${sample}_trimmed_R2.fq.gz \
        -j report_files/${sample}_fastp.json
        """
}

process runMultiQC {
        cpus {8}
        publishDir "${out_dir_qc}/", mode: 'copy', otherwise: false
        input:
                file('*') from json_report.collect()
        output:
                file("multiqc_report.html")
        """
        module load MultiQC/1.12
        multiqc .
        """
}
