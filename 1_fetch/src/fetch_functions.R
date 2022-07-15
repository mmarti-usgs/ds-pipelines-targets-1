# Mackenzie Marti (mmarti-usgs, mmarti@usgs.gov)
#
# This script defines functions related to fetching data.

library(dplyr)
library(readr)
library(stringr)
library(sbtools)
library(whisker)

# retrieve data from ScienceBase
retrieve_SB_data <- function(outPath) {
  mendota_file <- outPath
  item_file_download('5d925066e4b0c4f70d0d0599', names = 'me_RMSE.csv', destinations = mendota_file, overwrite_file = TRUE)
}
