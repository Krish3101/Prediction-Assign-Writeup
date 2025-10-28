############################################################
# Practical Machine Learning Project
# Predicting Exercise Quality from Activity Monitors
# Author: Krishkumar Kalya
# Date: October 2025
############################################################

# ---- 1. Load Required Libraries ----
if(!require(caret)) install.packages("caret", dependencies=TRUE)
if(!require(randomForest)) install.packages("randomForest", dependencies=TRUE)
if(!require(rpart)) install.packages("rpart", dependencies=TRUE)
if(!require(rpart.plot)) install.packages("rpart.plot", dependencies=TRUE)

library(caret)
library(randomForest)
library(rpart)
library(rpart.plot)

set.seed(9999)

# ---- 2. Download Data ----
train_url <- "https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv"
test_url  <- "https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv"

if(!dir.exists("data")) dir.create("data")
if(!dir.exists("data/submission")) dir.create("data/submission")

train_file <- "./data/pml-training.csv"
test_file  <- "./data/pml-testing.csv"

if(!file.exists(train_file)) download.file(train_url, destfile=train_file)
if(!file.exists(test_file)) download.file(test_url, destfile=test_file)

# ---- 3. Load & Clean Data ----
train <- read.csv(train_file, na.strings=c("NA", "#DIV/0!", ""))
test  <- read.csv(test_file,  na.strings=c("NA", "#DIV/0!", ""))

# Remove columns with NAs or irrelevant identifiers
train <- train[, colSums(is.na(train)) == 0]
test  <- test[,  colSums(is.na(test)) == 0]

train <- train[ , -c(1:7)]
test  <- test[ , -c(1:7)]

# ---- 4. Split Data (75% train / 25% validation) ----
inTrain <- createDataPartition(y=train$classe, p=0.75, list=FALSE)
training <- train[inTrain, ]
validation <- train[-inTrain, ]

# ---- 5. Train Decision Tree ----
model_dt <- rpart(classe ~ ., data=training, method="class")
pred_dt <- predict(model_dt, validation, type="class")
cat("Decision Tree Accuracy:\n")
print(confusionMatrix(pred_dt, validation$classe)$overall['Accuracy'])

# ---- 6. Train Random Forest ----
model_rf <- randomForest(classe ~ ., data=training, importance=TRUE)
pred_rf <- predict(model_rf, validation, type="class")
cat("\nRandom Forest Accuracy:\n")
print(confusionMatrix(pred_rf, validation$classe)$overall['Accuracy'])

# ---- 7. Final Model on Full Training Data ----
final_model <- randomForest(classe ~ ., data=train, importance=TRUE)

# ---- 8. Predict on Test Data ----
pred_test <- predict(final_model, test, type="class")
cat("\nFinal Predictions for Submission:\n")
print(pred_test)

# ---- 9. Generate Submission Files ----
pml_write_files <- function(x){
  n = length(x)
  for(i in 1:n){
    filename = paste0("./data/submission/problem_id_", i, ".txt")
    write.table(x[i], file=filename, quote=FALSE, row.names=FALSE, col.names=FALSE)
  }
}

pml_write_files(pred_test)

cat("\n✅ Submission files written to /data/submission/\n")

# ---- 10. Session Info ----
sessionInfo()

