# Diabetes Prediction and Exploratory Data Analysis

This repository contains an R script for analyzing and predicting diabetes using the diabetes dataset. The script includes data loading, preprocessing, exploratory data analysis (EDA), and the implementation of two machine learning models: Support Vector Machine (SVM) and Decision Tree.

## Table of Contents
1. [Dependencies](#dependencies)
2. [Dataset](#dataset)
3. [Data Preprocessing](#data-preprocessing)
4. [Exploratory Data Analysis (EDA)](#exploratory-data-analysis-eda)
5. [Outlier Detection and Removal](#outlier-detection-and-removal)
6. [Feature Selection](#feature-selection)
7. [Machine Learning Models](#machine-learning-models)
   - [Support Vector Machine (SVM)](#support-vector-machine-svm)
   - [Decision Tree](#decision-tree)
8. [Model Evaluation](#model-evaluation)
9. [Conclusion](#conclusion)

## Dependencies
Make sure you have the following R libraries installed:

- tidyverse
- GGally
- pheatmap
- caret
- pROC
- e1071
- rpart
- rpart.plot

You can install these libraries using the following R commands:

```R
install.packages(c("tidyverse", "GGally", "pheatmap", "caret", "pROC", "e1071", "rpart", "rpart.plot"))


# Diabetes Prediction and Exploratory Data Analysis

## Dataset
The dataset used for this analysis is "diabetes.csv". It contains various features such as Glucose, BMI, Blood Pressure, Age, and the target variable Outcome.

## Data Preprocessing
- **Loading the dataset:** The data is loaded using the `read.csv` function.
- **Checking for null values and duplicated values:** The script verifies if the dataset has any missing or duplicate values.
- **Handling outliers using the interquartile range (IQR) method:** Outliers are identified and addressed using the IQR method.
- **Exploratory Data Analysis (EDA):** The distribution of key features is visualized to gain insights into the data.

## Exploratory Data Analysis (EDA)
- **Pairwise plots:** Utilizing `ggpairs` for a quick overview of variable relationships.
- **Correlation heatmap:** Visualizing the correlation between numerical variables.
- **Histograms:** Individual variable distributions are presented for Glucose, BMI, Blood Pressure, and Age.

## Outlier Detection and Removal
- **Identifying outliers using the IQR method:** The script identifies outliers in the data.
- **Violin plots:** Visualizing the distribution of numerical variables with outliers.
- **Removing rows with identified outliers:** Rows containing outliers are removed from the dataset.

## Feature Selection
- **Selecting a subset of features:** Certain features are chosen for further analysis and visualization.

## Machine Learning Models
### Support Vector Machine (SVM)
- **Converting the target variable to a factor:** Preparing the target variable for SVM training.
- **Training an SVM model using the radial kernel:** Employing SVM for predictive modeling.
- **Model evaluation using accuracy:** Assessing the performance of the SVM model.
- **ROC curve:** Visualizing the performance of the SVM model.

### Decision Tree
- **Training a decision tree model:** Using the `rpart` package for decision tree modeling.
- **Model evaluation using accuracy:** Assessing the accuracy of the decision tree model.
- **Visualization of the decision tree:** The decision tree structure is visualized using `rpart.plot`.

## Model Evaluation
- **Evaluation metrics:** Metrics such as accuracy are used to evaluate the performance of both SVM and Decision Tree models.

## Conclusion
This script provides a comprehensive analysis of the diabetes dataset, including data preprocessing, exploratory data analysis, outlier detection, and the implementation of machine learning models (SVM and Decision Tree) for prediction. The models' performance is evaluated, and the results are visualized to enhance the understanding of the dataset.


