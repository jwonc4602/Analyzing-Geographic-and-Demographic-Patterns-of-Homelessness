#### Preamble ####
# Purpose: Simulates... [...UPDATE THIS...]
# Author: Rohan Alexander [...UPDATE THIS...]
# Date: 11 February 2023 [...UPDATE THIS...]
# Contact: rohan.alexander@utoronto.ca [...UPDATE THIS...]
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]


#### Workspace setup ####
library(tidyverse)
library(opendatatoronto)
library(dplyr)
library(ggplot2)

# get package
package <- show_package("21c83b32-d5a8-4106-a54f-010dbe49f6f2")
package

# get all resources for this package
resources <- list_package_resources("21c83b32-d5a8-4106-a54f-010dbe49f6f2")

# identify datastore resources; by default, Toronto Open Data sets datastore resource format to CSV for non-geospatial and GeoJSON for geospatial resources
datastore_resources <- filter(resources, tolower(format) %in% c('csv', 'geojson'))

# load the first datastore resource as a sample
data <- filter(datastore_resources, row_number()==1) %>% get_resource()
data

#### Simulate data ####
simulated_data <-
  tibble(
    # Use 1 through to 2703 to represent each division
    "Sector" = 1:2703,
    # Randomly pick an option, with replacement, 2703 times
    "User Group" = sample(
      x = c("Men", "Women", "Youth", "Mixed Adult", "Families"),
      size = 2703,
      replace = TRUE
    )
  )

simulated_data

# Count the occurrences of each User Group
counted_data <- simulated_data %>%
  count(`User Group`)

# Define custom colors for each User Group
user_group_colors <- c("Men" = "wheat3", "Women" = "wheat4", "Youth" = "wheat2", 
                       "Mixed Adult" = "wheat1", "Families" = "yellow4")

# Create a bar plot with custom colors
plot <- ggplot(counted_data, aes(x = `User Group`, y = n, fill = `User Group`)) +
  geom_bar(stat = "identity") +
  scale_fill_manual(values = user_group_colors) +  # Set custom colors
  labs(x = "User Group", y = "Count", title = "Distribution of User Groups") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))  # Rotate x-axis labels (optional)

# Display the plot
print(plot)

