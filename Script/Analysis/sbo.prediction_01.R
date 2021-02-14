# Libraries and options
library(here)
source(here("Script", "Functions", "funs_sbo_predict.R"))
source(here("Script", "Functions", "fun.time.R"))


# run data prep and cleaning.
fun.time(source(here("Script/Analysis/data_prepare_predict_01.R")))

# View the selected corpus.
View(combined)

# Create sbo predtable and save as .rda.
fun.time(t <- fun.create.t(N= 6))
save(t, file=here("Outputs", "predtable"))
save(t, file=here("Shiny", "predtable"))

# Create sbo predictor.
load(here("Outputs", "predtable"))
p <- fun.create.p()

# Clean input.
quiz2 <- readLines(here("Data", "quiz2.txt"))
quiz2 <- fun.textclean(quiz2)
# print prediction.
print(fun.predict(quiz2))

# same.
quiz3 <- readLines(here("Data", "quiz3.txt"))
quiz3 <- fun.textclean(quiz3)
print(fun.predict(quiz3))

# evaluate accuracy of prdeiction,
fun.time(acc <-fun.evaluate.p())
save(acc, file= here("Outputs", "accuracy"))
save(acc, file= here("Shiny", "accuracy"))
print(acc)
