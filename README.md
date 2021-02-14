# Coursera-Data-Science-Specialization_Course-10_Data-Science-Capstone
(https://github.com/pyfong1579/Coursera-Data-Science-Specialization_Course-10_Data-Science-Capstone/tree/master)

This project was the final part of a 10 course Data Science specialization by Johns Hopkins University on Coursera.
The Key partners for this project are Swiftkey and Coursera.
The project explores the Natural Language Processing facet of Data Science where a large text corpus of documents will be used to predict the next word on a preceding input in an interactive web application.

Relevant Links: Week 2 Milestone report. (https://rpubs.com/pyfong/720438)\
                Week 8 Final Report. (https://rpubs.com/pyfong/999999)\
                Pitch Slides. (https://rpubs.com/pyfong/999999)\

Runbook
1. Data provided from (https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip is preloaded into (./Data/).\
2. Analysis scripts are stored in (./Script/Analysis)\
    2.1 ./Script/Analysis/data_analysis_01.R - Script for the initial analysis of the data.\
    2.2 ./Script/Analysis/data_prepare_predict_01.R - Script for preparing data for the prediction model.\
    2.3 ./Script/Analysis/sbo.prediction_01.R - Script for prediction model creation and testing.\
3. Defined functions are stored in (./Script/Functions/)\
    3.1 ./Script/Functions/funs_dataprep.R - functions for analysing Data.\
    3.2 ./Script/Functions/funs_display.R - function for showing analysis of data esp. n-gram frequencies.\
    3.3 ./Script/Functions/funs_sbo_predict.R - functions for prediction model creation and testing.\
    3.4 ./Script/Functions/funs_textclean.R - functions for cleaning data.\
4. Shiny files are stored and uploaded from (./Shiny/).\
    4.1 ./Shiny/app.R - Shiny app containing UI, server and shinyApp.\
    4.2 ./Shiny//modern.css - CSS fi;le for shiny page formats.\
    4.2 ./Shiny//predtable - sbo predtable for model creation.\
    4.3 ./Shiny/accuracy - output table of model evaluation.\
    4.4 ./Shiny/Data/bad-words.txt - profanity dictionary text file.\
