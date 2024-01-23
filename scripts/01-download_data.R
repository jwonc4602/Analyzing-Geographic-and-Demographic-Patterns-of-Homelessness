#### Preamble ####
# Purpose: Downloads, saves, and reads data from the OpenDataToronto portal
# Author: Jiwon Choi
# Date: 22 January 2024
# Contact: jwon.choi@mail.utoronto.ca
# License: MIT
# Pre-requisites: None
# Data sets: https://open.toronto.ca/dataset/daily-shelter-overnight-service-occupancy-capacity/

#### Workspace setup ####
library(opendatatoronto)
library(tidyverse)

#### Download data ####
# Replace with the specific package ID for your dataset
package_id <- "21c83b32-d5a8-4106-a54f-010dbe49f6f2"

# Get the package
package <- show_package(package_id)
package

# Get all resources for this package
resources <- list_package_resources(package_id)

# Identify datastore resources; Toronto Open Data sets datastore resource format to CSV for non-geospatial
datastore_resources <- filter(resources, tolower(format) %in% c('csv'))

# Load the first datastore resource as a sample
data <- filter(datastore_resources, row_number() == 1) %>% get_resource()

# Save data
write_csv(raw_shelter_data, "inputs/data/raw_shelter_statistics.csv")  # Adjust the file path and name

# Read in the DAILY SHELTER & OVERNIGHT SERVICE OCCUPANCY & CAPACITY statistics data set
raw_shelter_data <- read_csv("inputs/data/raw_shelter_statistics.csv")

