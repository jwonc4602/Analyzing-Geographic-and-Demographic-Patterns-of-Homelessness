#### Preamble ####
# Purpose: Tests the cleaned dataset
# Author: Jiwon Choi
# Date: 23 January 2024
# Contact: jwon.choi@mail.utoronto.ca
# License: MIT
# Pre-requisites: 01-download.R, 02-data_cleaning

#### Workspace setup ####
library(tidyverse)

# Read the finalized data
finalized_shelter_data <- read_csv("outputs/data/finalized_shelter_statistics.csv")

# Test data types
class(finalized_shelter_data$occupancy_date)[1] == "Date"

# Assuming 'occupancy_rate' should be numeric
is.numeric(finalized_shelter_data$occupancy_rate)

# Test that occupancy dates are within a specific range
min(finalized_shelter_data$occupancy_date) >= as.Date("2024/01/01")
max(finalized_shelter_data$occupancy_date) <= as.Date("2024/01/21")

# Test unique values in 'sector'
finalized_shelter_data$sector |> unique() == c("Families", "Mixed Adult", "Men", "Women", "Youth")

# Test unique values in 'capacity_type'
finalized_shelter_data$capacity_type |> unique() == c("Room Based Capacity", "Bed Based Capacity")

# Test unique values in 'location_city'
finalized_shelter_data$location_city |> unique() == c("Toronto", "North York", "Etobicoke", "Scarborough", "Vaughan", "NA")

