# Mackenzie Marti (mmarti-usgs, mmarti@usgs.gov)
#
# This script defines functions related to fetching data.

library(dplyr)
library(readr)
library(stringr)
library(sbtools)
library(whisker)

# retrieve data from ScienceBase
retrieve_SB_data <- function(project_output_dir) {
  mendota_file <- file.path(project_output_dir, 'model_RMSEs.csv')
  item_file_download('5d925066e4b0c4f70d0d0599', names = 'me_RMSE.csv', destinations = mendota_file, overwrite_file = TRUE)
}
