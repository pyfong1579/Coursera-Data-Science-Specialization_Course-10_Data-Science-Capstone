sumtab <- function(t1, t2, t3) {
    # capturing row labels
    lbl1 <- substitute(t1); lbl2 <- substitute(t2); lbl3 <- substitute(t3)
    lbl <- sapply(c(lbl1, lbl2,lbl3),deparse)
    # getting object sizes
    SizeMB <- c(object.size(t1), object.size(t2), object.size(t3))/1024^2
    # calculating Words per Line Stats
    WPL= sapply(list(t1, t2, t3), function(x) summary(stri_count_words(x))[c('Min.', 'Mean', 'Max.')])
    rownames(WPL)=c('WPLmin', 'WPLmean', 'WPLmax')
    # setting up output table
    stats= data.frame(Dataset= lbl, SizeMB,
                      t(rbind(sapply(list(t1,t2,t3),stri_stats_general)[c('Lines','Chars'),],
                              sapply(list(t1,t2,t3),stri_stats_latex)[c('CharsWhite','Words'),], WPL)))
    # Printing summary table
    kbl(stats, digits=2, format.args = list(big.mark= ",", scientific = F)) %>%
        kable_minimal(full_width = T, position = "float_right")
}