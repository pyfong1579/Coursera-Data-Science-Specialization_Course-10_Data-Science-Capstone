# tokenization function
tokenize <- function(data, ngram, minfreq) {
    token <- function(data) NGramTokenizer(data, Weka_control(min= ngram, max= ngram))
    matrix <- TermDocumentMatrix(data, control= list(tokenize= token))
    freq <- findFreqTerms(matrix, lowfreq= minfreq)
    freqdata <- sort(rowSums(as.matrix(matrix[freq,])), decreasing= T)
    freqdata <- data.frame(Phrase= names(freqdata), Frequency= freqdata, row.names = NULL)
    return(freqdata)
}