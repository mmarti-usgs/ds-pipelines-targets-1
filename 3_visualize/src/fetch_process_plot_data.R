# Mackenzie Marti (mmarti-usgs, mmarti@usgs.gov)
#
# This script fetches, processes, and plots the data.

source("1_fetch/src/fetch_functions.R")
source("2_process/src/process_functions.R")
source("3_visualize/src/plot_functions.R")

# fetch data
project_output_dir <- "1_fetch/out"
data <- retrieve_SB_data(project_output_dir)

# process data
project_output_dir <- "2_process/out"
eval_data <- prep_data(data, project_output_dir)
# save processed data
save_processed_data(eval_data, project_output_dir)
# save model diagnostics
save_model_diagnostics(eval_data, project_output_dir)

# plot data
project_output_dir <- "3_visualize/out"
create_plot(eval_data, project_output_dir)

