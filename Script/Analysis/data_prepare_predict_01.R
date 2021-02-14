## data_prepare_predict_01.R

# Libraries and options
library(here)       # For easy directory maneuvering.
library(readtext)   # Data input package
library(stringi)    # For string processing and examination.
library(caTools)    # Data manipulation utility.
library(dplyr)      # Data handling.
library(quanteda)   # Textual data analyzer.
source(here("Script", "Functions", "funs_textclean.R"))
quanteda_options(threads= 8)

# Read in data 
blogs <- readLines(here("Data", "en_US", "en_US.blogs.txt"), encoding = "UTF-8", skipNul= T)
news <- readLines(here("Data", "en_US", "en_US.news.txt"), encoding = "UTF-8", skipNul= T)
twitter <- readLines(here("Data", "en_US", "en_US.twitter.txt"), encoding = "UTF-8", skipNul= T)

# Sample and combine data.
set.seed(1357) # Repeatable sampling.
samplesize <- 0.05
blogs_smp <- sample(blogs, length(blogs) * samplesize)
news_smp <- sample(news, length(news) * samplesize)
twitter_smp <- sample(twitter, length(twitter) * samplesize)
combined = c(blogs_smp, news_smp, twitter_smp)

rm(blogs, blogs_smp, news, news_smp, twitter, twitter_smp) # clear memory.

# Clean data with textclean package
combined <- fun.textclean(combined)

# Split into train and validation sets
split <- sample.split(combined, 0.8)
train <- subset(combined, split == T)
valid <- subset(combined, split == F)
#*** rm(combined) # clear memory.

# Transfer to quanteda corpus format. 
#train <- corpus(train)
#valid <- corpus(valid)
