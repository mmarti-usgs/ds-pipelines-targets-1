library(targets)
source("1_fetch/src/fetch_functions.R")
source("2_process/src/process_functions.R")
source("3_visualize/src/plot_functions.R")

tar_option_set(packages = c("tidyverse", "sbtools", "whisker"))

list(
  # Get the data from ScienceBase
  tar_target(
    data,
    retrieve_SB_data(outPath = "1_fetch/out/model_RMSEs.csv"),
    format = "file"
  ), 
  # Prepare the data for plotting
  tar_target(
    eval_data,
    prep_data(data),
  ),
  # Create a plot
  tar_target(
    figure_1_png,
    create_plot(eval_data, outPath = "3_visualize/out/figure_1.png"), 
    format = "file"
  ),
  # Save the processed data
  tar_target(
    model_summary_results_csv,
    save_processed_data(eval_data, outPath = "2_process/out/model_summary_results.csv"), 
    format = "file"
  ),
  # Save the model diagnostics
  tar_target(
    model_diagnostic_text_txt,
    save_model_diagnostics(eval_data, outPath = "2_process/out/model_diagnostic_text.txt"), 
    format = "file"
  )
)