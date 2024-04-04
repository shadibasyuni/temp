
library("dndscv")

muts = read.table(gzfile('/workspace/projects/intogen_2017/runs/20190124/dndscv/CBIOP_WXS_MDS_TOKYO_2011.in.gz'), sep = '\t', header = TRUE)

writeOutput = 0
result = tryCatch({
    dndscv(muts, refdb="/workspace/projects/intogen_2017/pipeline/datasets/hg38_vep92_develop/dndscv/RefCDS.rda")
    writeOutput = 1
}, error=function(e) {
    message('There was an error')
    writeOutput = 2
})

if (writeOutput == 1) {
    write.table(result$sel_cv, 'file1.txt', quote=FALSE, sep='\t', row.names = FALSE)
    write.table(result$annotmuts, 'file2.txt', sep = "\t", quote = FALSE, row.names = FALSE)
    write.table(result$genemuts, 'file3.txt', sep = "\t", quote = FALSE, row.names = FALSE)
} else {
    df = data.frame(
        gene_name=character(),
        n_syn=character(),
        n_mis=character(),
        n_non=character(),
        n_spl=character(),
        n_ind=character(),
        wmis_cv=character(),
        wnon_cv=character(),
        wspl_cv=character(),
        wind_cv=character(),
        pmis_cv=character(),
        ptrunc_cv=character(),
        pallsubs_cv=character(),
        pind_cv=character(),
        qmis_cv=character(),
        qtrunc_cv=character(),
        qallsubs_cv=character(),
        pglobal_cv=character(),
        qglobal_cv=character(),
	stringsAsFactors=FALSE
    )
    write.table(df, 'file1.txt', sep = "\t", quote = FALSE, row.names = FALSE)

    df = data.frame(
        sampleID=character(),
        chr=character(),
        pos=character(),
        ref=character(),
        mut=character(),
        gene=character(),
        strand=character(),
        ref_cod=character(),
        mut_cod=character(),
        ref3_cod=character(),
        mut3_cod=character(),
        aachange=character(),
        ntchange=character(),
        codonsub=character(),
        impact=character(),
        pid=character(),
	stringsAsFactors=FALSE
    )
    write.table(df, 'file2.txt', sep = "\t", quote = FALSE, row.names = FALSE)

    df = data.frame(
        gene_name=character(),
        n_syn=character(),
        n_mis=character(),
        n_non=character(),
        n_spl=character(),
        exp_syn=character(),
        exp_mis=character(),
        exp_non=character(),
        exp_spl=character(),
        exp_syn_cv=character(),
	stringsAsFactors=FALSE
    )
    write.table(df, 'file3.txt', sep = "\t", quote = FALSE, row.names = FALSE)
}


