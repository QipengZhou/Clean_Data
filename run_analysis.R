library(dplyr)

#setwd("uridataset") #set current working directory to uridataset's directory

test.sub <- read.table("test/subject_test.txt")
test.x <- read.table("test/X_test.txt", strip.white = TRUE)
test.y <- read.table("test/y_test.txt")

train.sub <- read.table("train/subject_train.txt")
train.x <- read.table("train/X_train.txt", strip.white = TRUE)
train.y <- read.table("train/y_train.txt")

activity_labels <- read.table("activity_labels.txt", stringsAsFactors = FALSE)
features <- read.table("features.txt", stringsAsFactors = FALSE)

test_data <- cbind(test.sub, test.x, test.y)
train_data <- cbind(train.sub, train.x, train.y)

merge_data <- rbind(test_data, train_data) # Step 1

mean_std_idx <- grep("mean\\(\\)|std\\(\\)", features[[2]])
mean_std_data <- merge_data[,c(1, 1+mean_std_idx, ncol(merge_data))] # Step 2

# Step3
mean_std_data[["V1.2"]] <- factor(mean_std_data[["V1.2"]], levels=activity_labels[[1]], labels=activity_labels[[2]])

names(mean_std_data) <- c("user_id", features[[2]][mean_std_idx], "labels") # Step4

mean_std_data.group <- select(mean_std_data, -c(user_id, labels))
temps <- split(mean_std_data.group, list(mean_std_data$user_id, mean_std_data$labels), drop=TRUE)
res_tidy <- lapply(temps, function(x){colMeans(x)})
data_tidy <- data.frame(matrix(unlist(res_tidy), nrow=length(res_tidy), byrow = TRUE))
row.names(data_tidy) <- names(res_tidy)
colnames(data_tidy) <- names(res_tidy[[1]])
