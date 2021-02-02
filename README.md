# Coursera-Data-Science-Specialization_Course-10_Data-Science-Capstone
(https://github.com/pyfong1579/Coursera-Data-Science-Specialization_Course-10_Data-Science-Capstone/new)

This project was the final part of a 10 course Data Science track by Johns Hopkins University on Coursera. It was done as an industry partnership with SwiftKey. The job was to clean and analyze a large corpus of unstructured text and build a word prediction model and use it in a web application.

More info here: (http://rpubs.com/akselix/word_prediction)

Runbook
Shiny app

Data is preloaded into (./shiny/data/)

./shiny/prediction.R

Contains most of the functions used by the other scripts
./shiny/server.R

Contains the server side functions
./shiny/ui.R

Handles the input/output
Preparing the data and validation

./shiny/prediction.R

Contains most of the functions used by the other scripts
./prepare_data.R

Data is cleaned and tokenized with this
./test_prediction.R

Run manual tests
./validation.R

Run an automated accuracy calculation on validation data
