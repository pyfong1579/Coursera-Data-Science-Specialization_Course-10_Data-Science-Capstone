## functions for textclean funs_textclean.R

library(here)       # For easy directory maneuvering.
library(textclean)  # For cleaning text data.
library(textshape)  # For cleaning text data.
library(stringi)    # For string processing and examination.
library(utf8)       # Encoding management.
library(stopwords)  # stopwords package.
library(dplyr)      # Data handling.

# Function for using textclean to check the text object output to file.
fun.chktext <- function(x, file = "textcheck.txt") {
    check_text(x, here("Outputs", file))
}

# Function cleaning text object
fun.textclean <- function(x) {
    
    # Set up vectors for profanity and stop words.
    profanity <- readLines(here("Data", "bad-words.txt"))   # source: www.cs.cmu.edu
    profanity <- paste(" ", profanity, " ", sep= "")
    stop <- stopwords("en", simplify= T)                    # source: snowball
    stop <- paste(" ", stop, " ", sep= "")
    
    # Convert standardize encoding.
    x %>% as_utf8( normalize=T) %>%
        stri_enc_toascii() %>% # removes other languages as well.
    
        # initialize as text object
        as.character() %>%
        
        # Replace contractions
        replace_contraction() %>%
        
        # replace date content with blank character or remove date content
#        replace_date(replacement = "") %>%
    
        # replace number
#        replace_number(remove= T) %>%
    
        # remove email
        replace_email() %>%
    
        # replace emoticon
        replace_emoticon() %>%
    
        # replace white (escaped back space characters)
        replace_white() %>%
        
        # remove hashtags
        replace_hash() %>%
        
        # remove HTML
        replace_html(symbol = F)  %>%
        
        # remove incomplete sentence
        replace_incomplete(replacement= "") %>%
        
        # remove kerning
        replace_kern() %>%
        
        # add missing endmarks
        add_missing_endmark() %>%
        
        # add space after comma
        add_comma_space() %>%
        
        # replace non ASCII
        replace_non_ascii() %>%
        
        # remove tag
#        replace_tag() %>%
        
        # remove time stamps
#        replace_time() %>%
        
        # remove url
        replace_url(replacement= "") %>%
        
        # remove profanities
        mgsub(pattern= profanity, replacement= " ", ignore.case= T, fixed= F) %>%
        
        # remove stop words
#        mgsub(pattern= stop, replacement= " ", ignore.case= T, fixed= F) %>%        

        # misspelled
#        %>%(x11)
    
        # no alpha
#        %>% (x12)

        # strip symbols and change to lowercase
        strip()
    
        # split sentences
        #%>% split_sentence()
    
        # Remove empty row
        #%>% data.frame()
        #%>% drop_empty_row()
        #%>% as.character()

}
