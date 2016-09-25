library(dplyr)

#setwd("uridataset") #set current working directory to uridataset's directory

test.sub <- read.table("test/subject_test.txt")
names(test.sub) <- c("sub_id")
test.x <- read.table("test/X_test.txt", strip.white = TRUE)
test.y <- read.table("test/y_test.txt")
names(test.y) <- c("label")

train.sub <- read.table("train/subject_train.txt")
names(train.sub) <- c("sub_id")
train.x <- read.table("train/X_train.txt", strip.white = TRUE)
train.y <- read.table("train/y_train.txt")
names(train.y) <- c("label")

activity_labels <- read.table("activity_labels.txt", stringsAsFactors = FALSE)
names(activity_labels) <- c("label", "actName")
features <- read.table("features.txt", stringsAsFactors = FALSE)

test_data <- cbind(test.sub, test.x, test.y)
train_data <- cbind(train.sub, train.x, train.y)

# Step 1
merge_data <- rbind(test_data, train_data)

# Step 2
mean_std_idx <- grep("mean\\(\\)|std\\(\\)", features[[2]])
mean_std_data <- merge_data[,c(1, 1+mean_std_idx, ncol(merge_data))] 

# Step3
mean_std_data <- inner_join(mean_std_data, activity_labels)

# Step4
names(mean_std_data)[2:(length(names(mean_std_data))-2)] <- make.names(features[[2]][mean_std_idx])

# Step5
mean_std_data.group <- mean_std_data %>% select(-matches("label")) %>% group_by(sub_id, actName)
res <- mean_std_data.group %>% summarise_each(funs(mean))
res
