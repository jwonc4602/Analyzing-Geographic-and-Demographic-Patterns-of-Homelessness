#### Preamble ####
# Purpose: Simulate the 2024 DAILY SHELTER & OVERNIGHT SERVICE OCCUPANCY & CAPACITY statistics data set
# Author: Jiwon Choi
# Date: 22 January 2024
# Contact: jwon.choi@mail.utoronto.ca
# License: MIT
# Pre-requisites: None
# Data sets:https://open.toronto.ca/dataset/daily-shelter-overnight-service-occupancy-capacity/


#### Workspace setup ####
library(tidyverse)
library(ggplot2)
library(opendatatoronto)
library(dplyr)

#### Simulation 1) Distribution of User Groups ####
set.seed(1250)  # Set a specific seed value for reproducibility

simulated_data1 <-
  tibble(
    # Use 1 through to 2703 to represent each division
    "Sector" = 1:2839,
    # Randomly pick an option, with replacement, 2703 times
    "User Group" = sample(
      x = c("Men", "Women", "Youth", "Mixed Adult", "Families"),
      size = 2839,
      replace = TRUE
    )
  )

simulated_data1

# Count the occurrences of each User Group
counted_data1 <- simulated_data1 %>%
  count(`User Group`)

# Define custom colors for each User Group
user_group_colors <- c("Men" = "wheat3", "Women" = "wheat4", "Youth" = "wheat2", 
                       "Mixed Adult" = "wheat1", "Families" = "yellow4")

# Create a bar plot with custom colors and count labels
plot1 <- ggplot(counted_data1, aes(x = `User Group`, y = n, fill = `User Group`)) +
  geom_bar(stat = "identity") +
  scale_fill_manual(values = user_group_colors) +  # Set custom colors
  labs(x = "User Group", y = "Count", title = "Distribution of User Groups") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +  # Rotate x-axis labels (optional)
  geom_text(aes(label = n), vjust = -0.5, size = 3)  # Add count labels above the bars

# Display the plot
print(plot1)

### Simulation 2) distribution of capacity type ###
set.seed(1250)  # Set a specific seed value for reproducibility

simulated_data2 <-
  tibble(
    "Capacity Type" = 1:2839,
    "Type" = sample(
      x = c("Bed Based Capacity", "Room Based Capacity"),
      size = 2839,
      replace = TRUE
    )
  )

# Count the occurrences of each Capacity Type
counted_data2 <- simulated_data2 %>%
  count(Type)

# Define custom colors for each Capacity Type
capacity_type_colors <- c("Bed Based Capacity" = "wheat3", "Room Based Capacity" = "wheat4")

# Create a pie chart with percentage labels
plot2 <- ggplot(counted_data2, aes(x = "", y = n, fill = Type)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar(theta = "y") +
  scale_fill_manual(values = capacity_type_colors) +
  labs(x = NULL, y = NULL, fill = "Capacity Type", title = "Distribution of Capacity Type") +
  theme_void() +  # Removes axis and background elements
  geom_text(
    aes(label = scales::percent(n / sum(n))),
    position = position_stack(vjust = 0.5),
    size = 4
  )

# Display the pie chart with percentage labels
print(plot2)

# Simulation 3) distribution of location
set.seed(1250)  # Set a specific seed value for reproducibility

simulated_data3 <- tibble(
  "Location City" = 1:2839,
  "Location" = sample(
    x = c("Toronto", "North York", "Scarborough", "Etobicoke", "Vaughan"),
    size = 2839,
    replace = TRUE
  )
)

# Count the occurrences of each Location
counted_data3 <- simulated_data3 %>%
  count(Location)

# Define custom colors for each Location
location_colors <- c("Toronto" = "wheat3", "North York" = "wheat4", "Scarborough" = "wheat2", 
                     "Etobicoke" = "wheat1", "Vaughan" = "yellow4")

# Create a bar plot
plot3 <- ggplot(counted_data3, aes(x = Location, y = n, fill = Location)) +
  geom_bar(stat = "identity") +
  scale_fill_manual(values = location_colors) +
  labs(x = "Location", y = "Count", fill = "Location", title = "Distribution of Location") +
  theme_minimal() +
  theme(legend.position = "none") +  # Remove legend
  geom_text(aes(label = n), vjust = -0.2, size = 4)  # Add count labels

# Display the bar plot
print(plot3)

