# Load necessary libraries
library(readxl)  # For reading Excel files
library(dplyr)   # For data manipulation
library(stats)   # For statistical functions
library(cluster) # For clustering algorithms
library(ggplot2) # For data visualization

# Define the path to the dataset
dataset_path <- "C:/Users/adars/Downloads/NBA_Player_Stats.xlsx"

# Load the dataset into R
nba_stats <- read_excel(dataset_path)

# View the first few rows of the dataset
head(nba_stats)

# Extract the column names (variable names) from the dataset
variable_names <- colnames(nba_stats)

# Create a data frame with descriptions for each variable
variable_descriptions <- data.frame(
  Initial = variable_names,
  FullName = c("Rank", "Player", "Position", "Age", "Team", "Games", "Games Started",
               "Minutes Played", "Field Goals", "Field Goal Attempts", "Field Goal Percentage",
               "3-Point Field Goals", "3-Point Field Goal Attempts", "3-Point Field Goal Percentage",
               "2-Point Field Goals", "2-Point Field Goal Attempts", "2-Point Field Goal Percentage",
               "Effective Field Goal Percentage", "Free Throws", "Free Throw Attempts", "Free Throw Percentage",
               "Offensive Rebounds", "Defensive Rebounds", "Total Rebounds", "Assists",
               "Steals", "Blocks", "Turnovers", "Personal Fouls", "Points", "Season", "Most Valuable Player"),
  Description = c("A unique identifier for each row/player.",
                  "The name of the player.",
                  "The playing position of the player.",
                  "The age of the player.",
                  "The NBA team the player played for in that season.",
                  "The number of games the player appeared in.",
                  "The number of games the player started.",
                  "The total minutes the player played.",
                  "The total number of field goals made.",
                  "The total number of field goal attempts.",
                  "The percentage of field goal attempts made.",
                  "The total number of 3-point field goals made.",
                  "The total number of 3-point field goal attempts.",
                  "The percentage of 3-point field goal attempts made.",
                  "The total number of 2-point field goals made.",
                  "The total number of 2-point field goal attempts.",
                  "The percentage of 2-point field goal attempts made.",
                  "Adjusted field goal percentage accounting for 3-pointers.",
                  "The total number of free throws made.",
                  "The total number of free throw attempts.",
                  "The percentage of free throw attempts made.",
                  "The total number of offensive rebounds.",
                  "The total number of defensive rebounds.",
                  "The total number of rebounds.",
                  "The total number of assists.",
                  "The total number of steals.",
                  "The total number of blocks.",
                  "The total number of turnovers.",
                  "The total number of personal fouls.",
                  "The total number of points scored.",
                  "The NBA season.",
                  "Boolean indicating if the player was MVP that season.")
)

# Print the variable descriptions
print(variable_descriptions)

# Check for missing values in the dataset
missing_values <- sapply(nba_stats, function(x) sum(is.na(x)))
print(missing_values)

# Remove rows with missing values
nba_stats_clean <- na.omit(nba_stats)

# Adjust column selection to exclude non-numeric columns
numerical_columns <- nba_stats_clean %>% select(-c(Rk, Player, Pos, Tm, Season, MVP))

# Normalize the numerical data
nba_stats_normalized <- scale(numerical_columns)

# Check the structure of the normalized data
str(nba_stats_normalized)

# Perform Principal Component Analysis (PCA) on the normalized data
pca_result <- prcomp(nba_stats_normalized, center = FALSE, scale. = FALSE)

# View a summary of the PCA results
summary(pca_result)

# Plot the variance explained by each principal component
plot(pca_result$sdev^2 / sum(pca_result$sdev^2), xlab = "Principal Component", ylab = "Variance Explained", type = 'b')

# Extract the scores of the first three principal components
pca_scores <- as.data.frame(pca_result$x[, 1:3])

# Print the first few rows of the PCA scores
print(head(pca_scores))

# Check the range (min and max) for each of the first three principal components
min_pc1 <- min(pca_scores$PC1)
print(min_pc1)
max_pc1 <- max(pca_scores$PC1)
print(max_pc1)

min_pc2 <- min(pca_scores$PC2)
print(min_pc2)
max_pc2 <- max(pca_scores$PC2)
print(max_pc2)

min_pc3 <- min(pca_scores$PC3)
print(min_pc3)
max_pc3 <- max(pca_scores$PC3)
print(max_pc3)

# Perform K-means clustering on the PCA scores with 5 clusters
kmeans_result <- kmeans(pca_scores, centers = 5)

# Print the summary of K-means clustering results
print(kmeans_result)

# Summary of the clustering result (cluster centers, sizes, etc.)
summary(kmeans_result)

# Add the cluster assignments to the PCA scores
pca_scores$cluster <- as.factor(kmeans_result$cluster)

# Create a scatter plot of the first two principal components, colored by cluster
ggplot(pca_scores, aes(x = PC1, y = PC2, color = cluster)) +
  geom_point() +
  ggtitle("NBA Player Clusters Based on PCA")

