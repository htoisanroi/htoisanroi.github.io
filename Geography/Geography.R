# Load libraries
library(janitor)
library(magrittr)
library(dplyr)
library(tidycensus)
library(sf)
library(openxlsx)   # for writing Excel files

# Set Census API key (overwrite if already exists)
census_api_key("82094a8b267df984444ea32ab32f235747e60822",
               install = TRUE,
               overwrite = TRUE)

# Get ACS 5-year data for ALL Texas counties
tx_counties_2023 <- get_acs(
  geography = "county",
  table = "DP05",     # Demographic Profile table
  state = "TX",       # Texas
  survey = "acs5",    # 5-year ACS
  year = 2023,        # latest available
  geometry = FALSE    # TRUE if you also want shapefiles
) %>%
  clean_names()

# ---- Save outputs ----
# Create folder if it doesn't exist
if (!dir.exists("DataOut")) {
  dir.create("DataOut")
}

# Save to CSV
write.csv(tx_counties_2023,
          "DataOut/tx_counties_DP05_2023.csv",
          row.names = FALSE)

# Preview first rows
head(tx_counties_2023)

getwd()

