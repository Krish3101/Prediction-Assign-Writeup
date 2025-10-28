# Prediction-Assign-Writeup

# Practical Machine Learning Project  
### Predicting Exercise Quality from Activity Monitors  

**Author:** Your Name  
**Course:** Practical Machine Learning (Coursera)  
**Date:** October 2025  

---

## 📘 Project Overview  

This project is part of the **Coursera Practical Machine Learning** course offered by Johns Hopkins University.  
The objective is to predict how well individuals performed specific physical exercises using data from accelerometers placed on the belt, forearm, arm, and dumbbell.  

The dependent variable is **`classe`**, which indicates one of five different exercise execution types:  

| Class | Description |
|:------|:-------------|
| A | Performed correctly |
| B | Throwing elbows forward |
| C | Lifting halfway only |
| D | Lowering halfway only |
| E | Throwing hips forward |

---

## ⚙️ Methods and Tools  

**Programming Language:** R  
**Main Libraries Used:**  
- `caret` — data partitioning, model training, validation  
- `randomForest` — ensemble classification model  
- `dplyr` — data cleaning and manipulation  

**Model Used:** Random Forest  
**Accuracy Achieved:** ~99%  
**Expected Out-of-Sample Error:** <1%

---

## 🧠 Workflow  

1. **Data Loading** — Download and load the training/testing datasets from Coursera.  
2. **Cleaning** — Remove irrelevant columns (timestamps, names) and those with missing values.  
3. **Partitioning** — Split training data into 75% training and 25% validation sets.  
4. **Model Training** — Use a Random Forest classifier with 5-fold cross-validation.  
5. **Evaluation** — Validate model performance with confusion matrix and accuracy score.  
6. **Submission Preparation** — Predict the 20 Coursera test cases and save individual text files for submission.

---

## 📊 Results  

- **Algorithm:** Random Forest  
- **Training Accuracy:** 0.995–0.999  
- **Validation Accuracy:** ~99%  
- **Expected Error Rate:** ~0.5%  
- **Best Performing Model:** Random Forest (outperformed Decision Tree baseline)  

---

## 📁 Files Included  

| File | Description |
|------|-------------|
| `analysis.Rmd` | R Markdown report containing full analysis and code |
| `analysis.html` | Compiled HTML report |
| `submission/` | Folder with 20 individual prediction files for Coursera submission |
| `README.md` | This project summary file |

---

## 🚀 Reproducibility  

To reproduce the analysis:

```r
# Install required packages
install.packages(c("caret", "randomForest", "dplyr"))

# Open and knit the R Markdown file
rmarkdown::render("analysis.Rmd")
