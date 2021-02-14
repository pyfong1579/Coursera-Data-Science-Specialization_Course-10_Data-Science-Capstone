# data_analysis_01.R

# Libraries and options
library(here)       # For easy directory maneuvering.
library(stringi)    # For string processing and examination.
library(caTools)    # Data manipulation utility.
source(here("Script", "Functions", "funs_dataprep.R"))
source(here("Script", "Functions", "funs_display.R")) 
quanteda_options(threads= 8)

# Read in data
blogs <- readLines(here("Data", "en_US", "en_US.blogs.txt"), encoding= "UTF-8", skipNul= T)
news <- readLines(here("Data", "en_US", "en_US.news.txt"), encoding= "UTF-8", skipNul= T)
twitter <- readLines(here("Data", "en_US", "en_US.twitter.txt"), encoding= "UTF-8", skipNul= T)

# Summary of raw datasets
fun.sumtab(blogs, news, twitter)

# Sample and combine data.
set.seed(1234) # Repeatable sampling.
samplesize <- 0.01
blogs_smp <- sample(blogs, length(blogs) * samplesize)
news_smp <- sample(news, length(news) * samplesize)
twitter_smp <- sample(twitter, length(twitter) * samplesize)
combined = c(blogs_smp, news_smp, twitter_smp)

# Summary of samples
fun.sumtab(blogs_smp, news_smp, twitter_smp)
rm(blogs, blogs_smp, news, news_smp, twitter, twitter_smp) # clear memory.

# Split into train and validation sets
split <- sample.split(combined, 0.8)
train <- subset(combined, split == T)
valid <- subset(combined, split == F)
rm(combined) # clear memory.

# Transfer to quanteda corpus format. 
train <- corpus(train)

# Set up vector of profanity words.
profanity <- readLines(here("Data", "bad-words.txt"))

# Clean & Tokenize ie uni grams
train1 <- tokens(train,
                 what= "word",
                 remove_punct = T,
                 remove_symbols = T,
                 remove_numbers = T,
                 remove_url = T,
                 remove_separators = T
                 ) %>%
    tokens_tolower() %>%
    tokens_remove(pattern= stopwords("en")) %>%
    tokens_remove(pattern= as.list(profanity))

# Create n-grams
train2 = fun.ngram(train1, 2)
train3 = fun.ngram(train1, 3)
#rm(train, profanity) # Clear memory.

# Frequency tables ####
freqtrain1 <- fun.freq(train1)
freqtrain2 <- fun.freq(train2)
freqtrain3 <- fun.freq(train2)
rm(train1, train2, train3) # Clear memory.

# Visualizations
fun.display(freqtrain1, "Uni-grams")
fun.display(freqtrain2, "Bi-grams")
fun.display(freqtrain3, "Tri-grams")

rm(freqtrain1, freqtrain2, freqtrain3) # temporary clear memory