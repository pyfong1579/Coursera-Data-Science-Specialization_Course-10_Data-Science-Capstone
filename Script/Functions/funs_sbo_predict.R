## functions using sbo predict funs_sbo_predict.R 
library(sbo)
library(dplyr)

#create predictor table
fun.create.t <- function(x= train, N= 3, L=3L) {
    sbo_predtable(object = x, # preloaded dataset
                  N = N, # Train an N-gram model
                  dict = target ~ 0.99, # cover x% of training corpus
                  # .preprocess = sbo::preprocess, # Preprocessing transformation 
                  EOS = ".?!:;", # End-Of-Sentence tokens
                  lambda = 0.4, # Back-off penalization in SBO algorithm
                  L = L, # Number of predictions for input
                  filtered = "<UNK>" # Exclude the <UNK> token from predictions
                  )
}

#create predictor object
fun.create.p <- function(x= t) {
    sbo_predictor(x)
}

# predicting inputs
fun.predict <- function(x) { 
    predict(p, x)
}

# evaluation of predictor function
fun.evaluate.p <- function(x= test) {
    set.seed(2468)
    (evaluation <- eval_sbo_predictor(p, test = valid))
    print(evaluation)

    acc <- evaluation %>% # Accuracy for in-sentence predictions
        filter(true != "<EOS>") %>%
        summarise(accuracy = sum(correct) / n(),
        uncertainty = sqrt(accuracy * (1 - accuracy) / n())
        )
    return(acc)
    print(acc)
}