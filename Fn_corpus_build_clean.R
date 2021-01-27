# Set up vector of profanity words
profanity <- file("./final/bad-words.txt", "r")
profanV <- VectorSource(readLines(profanity))

# Cleaning function
clean <- function(obj) {
    obj_clean <- VCorpus(VectorSource(obj))
    obj_clean <- tm_map(obj_clean, tolower)
    obj_clean <- tm_map(obj_clean, removeNumbers)
    obj_clean <- tm_map(obj_clean, removeWords, stopwords('SMART'))
    obj_clean <- tm_map(obj_clean, removePunctuation, ucp= T)
    obj_clean <- tm_map(obj_clean, removeWords, profanV)
    obj_clean <- tm_map(obj_clean, stripWhitespace)
    obj_clean <- tm_map(obj_clean, PlainTextDocument) # correcting data type after cleaning
}
# Display  summary table
blogs_cln <- clean(blogs_smp)
blogs_c_txt <- unlist(sapply(blogs_cln, '[', "content"))
news_cln <- clean(news_smp)
news_c_txt <- unlist(sapply(news_cln, '[', "content"))
twitter_cln <- clean(twitter_smp)
twitter_c_txt <- unlist(sapply(twitter_cln, '[', "content"))
sumtab(blogs_c_txt, news_c_txt, twitter_c_txt)

# Consolidating datasets
enUS_corp <- c(blogs_cln, news_cln, twitter_cln)
