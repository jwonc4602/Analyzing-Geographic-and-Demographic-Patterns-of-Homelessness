#### Preamble ####
# Purpose: Cleans and prepares the Daily Shelter & Overnight Service Occupancy & Capacity statistics data 
#          for analysis. This script focuses on data downloaded from the OpenDataToronto portal, ensuring 
#          it's in the correct format and ready for further statistical analysis or visualization.
# Author: Jiwon Choi
# Date: 22 January 2024
# Contact: jwon.choi@mail.utoronto.ca
# License: MIT
# Pre-requisites: 01-download.R (Script for downloading the data set from OpenDataToronto)

#### Workspace setup ####
library(tidyverse)
library(tidyr)
library(janitor)

#### Read and Process Data ####
# Read in the downloaded shelter data
raw_shelter_data <- read_csv("inputs/data/raw_shelter_statistics.csv")

# Process the data
cleaned_shelter_data <- raw_shelter_data |>
  janitor::clean_names() |>
  select(occupancy_date, sector, capacity_type, location_city, occupied_beds, capacity_actual_bed, occupied_rooms, capacity_actual_room) |>
  mutate(
    occupancy_date = as.Date(occupancy_date, format = "%Y-%m-%d"),
    sector = as.factor(sector),
    capacity_type = as.factor(capacity_type),
    location_city = as.factor(location_city),
    occupied_beds = replace_na(occupied_beds, 0),
    capacity_actual_bed = replace_na(capacity_actual_bed, 0),
    occupied_rooms = replace_na(occupied_rooms, 0),
    capacity_actual_room = replace_na(capacity_actual_room, 0),
    occupancy_rate_beds = ifelse(capacity_actual_bed > 0, occupied_beds / capacity_actual_bed, 0),
    occupancy_rate_rooms = ifelse(capacity_actual_room > 0, occupied_rooms / capacity_actual_room, 0),
    occupancy_rate = 100 * (occupancy_rate_beds + occupancy_rate_rooms) / 
      (ifelse(occupancy_rate_beds > 0, 1, 0) + ifelse(occupancy_rate_rooms > 0, 1, 0))
  )

#### Save Cleaned Data ####
# Save the cleaned data for further analysis
write_csv(cleaned_shelter_data, "outputs/data/cleaned_shelter_statistics.csv")

# Remove specific columns for the finalized data
finalized_shelter_data <- cleaned_shelter_data %>%
  select(-occupied_beds, -capacity_actual_bed, -occupied_rooms, -capacity_actual_room, -occupancy_rate_beds, -occupancy_rate_rooms)

#### Save Finalized Data ####
# Save the finalized data for further analysis
write_csv(finalized_shelter_data, "outputs/data/finalized_shelter_statistics.csv")

