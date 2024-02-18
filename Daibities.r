#importing laibaries
library(tidyverse)
library(GGally)
library(pheatmap)
library(caret)
library(pROC)
library(e1071)
library(rpart)
library(rpart.plot)
#loading data 
data <- read.csv("diabetes.csv")
head(data)

# checking if data has null values
any(is.na(data))

#checking if data has duplicated values
duplicated(data)

summary(data)


# checking and handling outliers
numerical_vars <- data %>%
  select_if(is.numeric)
detect_outliers <- function(x) {
  q1 <- quantile(x, 0.25)
  q3 <- quantile(x, 0.75)
  iqr <- q3 - q1
  lower_bound <- q1 - 1.5 * iqr
  upper_bound <- q3 + 1.5 * iqr
  outliers <- which(x < lower_bound | x > upper_bound)
  return(outliers)
}
outliers_list <- lapply(numerical_vars, detect_outliers)
outliers_df <- data.frame(
  Variable = rep(names(numerical_vars), sapply(outliers_list, length)),
  Outlier_Index = unlist(outliers_list)
)
print(outliers_df)
for (var in names(numerical_vars)) {
  ggplot(data, aes(x = 1, y = data[[var]])) +
    geom_violin(fill = "lightblue", color = "blue") +
    labs(title = paste("Violin Plot of", var), x = "", y = var) +
    theme_minimal() +
    theme(axis.text.x = element_blank(), axis.title.x = element_blank())
}
# Remove rows with outliers
data_clean <- data[-outliers_df$Outlier_Index, ]



#EDA
ggpairs(data_clean)


cor_matrix <- cor(data_clean)
corrplot(
  cor_matrix,
  method = "number",
  type = "upper",
  order = "original",
  col = colorRampPalette(c("blue", "black", "red"))(100)
)
ggplot(data_clean, aes(x = Glucose)) +
  geom_histogram(binwidth = 5, fill = "blue", color = "black") + 
  labs(title = "Distribution of Glucose", x = "Glucose", y = "Frequency")

ggplot(data_clean, aes(x = BloodPressure)) +
  geom_histogram(binwidth = 5, fill = "green", color = "black") + 
  labs(title = "Distribution of Blood Pressure", x = "Blood Pressure", y = "Frequency")

ggplot(data_clean, aes(x = BMI)) +
  geom_histogram(binwidth = 2, fill = "orange", color = "black") + 
  labs(title = "Distribution of BMI", x = "BMI", y = "Frequency")

ggplot(data_clean, aes(x = Age)) +
  geom_histogram(binwidth = 5, fill = "purple", color = "black") + 
  labs(title = "Distribution of Age", x = "Age", y = "Frequency")


# Bar plot for Outcome in cleaned data
ggplot(data_clean, aes(x = factor(Outcome), fill = factor(Outcome))) +
  geom_bar() +
  labs(title = "Distribution of Outcome", x = "Outcome", y = "Count") +
  scale_fill_manual(values = c("0" = "blue", "1" = "red"))




selected_vars <- c("Glucose", "BMI", "BloodPressure", "Age", "Outcome")
ggpairs(data_clean[, selected_vars], columns = 1:4, mapping = aes(color = factor(Outcome)))

# Scatterplot for selected variables
ggplot(data_clean, aes(x = Glucose, y = BMI, color = factor(Outcome))) +
  geom_point() +
  labs(title = "Scatterplot of Glucose vs. BMI", x = "Glucose", y = "BMI", color = "Outcome") +
  scale_color_manual(values = c("0" = "blue", "1" = "red"))









set.seed(123)

# Split the data into training and testing sets
split_index <- createDataPartition(data_clean$Outcome, p = 0.8, list = FALSE)
train_data <- data_clean[split_index, ]
test_data <- data_clean[-split_index, ]


#SVM 

# Convert Outcome to a factor
train_data$Outcome <- as.factor(train_data$Outcome)
# Train the SVM model
svm_model <- train(
  Outcome ~ .,
  data = train_data,
  method = "svmRadial",  # Radial kernel for non-linear relationships
  trControl = trainControl(method = "cv", number = 5, verboseIter = TRUE)
)
# Print the model summary
print(svm_model)
# Make predictions on the test set
predictions <- predict(svm_model, newdata = test_data)

# Evaluate the model using accuracy
svm_accuracy <- mean(predictions == test_data$Outcome)
print(paste("Accuracy:", svm_accuracy))

# Create a ROC curve for SVM
roc_svm <- roc(test_data$Outcome, as.numeric(predictions))

# Plot the ROC curve
plot(roc_svm, main = "ROC Curve - SVM", col = "blue")

#decision tree
decision_tree_model <- rpart(Outcome ~ ., data = train_data, method = "class")
summary(decision_tree_model)
rpart.plot(
  decision_tree_model,
  extra = 101,
  type = 0,
  fallen.leaves = TRUE,
  shadow.col = "gray",
  branch.lty = 1,
  under = TRUE,
  yesno = 2,
  main = "Decision Tree Plot"
)

tree_predictions <- predict(decision_tree_model, newdata = test_data, type = "class")
tree_accuracy <- mean(tree_predictions == test_data$Outcome)
print(paste("Decision Tree Accuracy:", tree_accuracy))


