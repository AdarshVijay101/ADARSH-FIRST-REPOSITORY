

This project performs data analysis on NBA player statistics, including Principal Component Analysis (PCA) for dimensionality reduction and K-means clustering to group players into similar performance categories.

## Project Overview

The project uses an NBA player stats dataset and performs the following steps:
1. Load and clean the dataset.
2. Conduct Principal Component Analysis (PCA) to reduce the dimensions of the data.
3. Normalize the data for better analysis.
4. Apply K-means clustering to categorize players based on performance metrics.
5. Visualize the clustering results using a scatter plot of the first two principal components.

## Requirements

- R (version 4.0.0 or higher)
- R packages:
  - `readxl` - For reading Excel files.
  - `dplyr` - For data manipulation.
  - `stats` - For statistical functions.
  - `cluster` - For clustering algorithms.
  - `ggplot2` - For data visualization.

You can install the required R packages using the following commands:

```r
install.packages("readxl")
install.packages("dplyr")
install.packages("ggplot2")
install.packages("cluster")
