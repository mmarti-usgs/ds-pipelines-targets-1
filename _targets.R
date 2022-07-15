library(targets)
source("1_fetch/src/fetch_functions.R")
source("2_process/src/process_functions.R")
source("3_visualize/src/visualize_functions.R")

tar_option_set(packages = c("tidyverse", "sbtools", "whisker"))

list(
  # Get the data from ScienceBase
  tar_target(
    model_RMSEs_csv,
    retrieve_SB_data(outPath = "1_fetch/out/model_RMSEs.csv"),
    format = "file"
  ), 
  # Prepare the data for plotting
  tar_target(
    data,
    prep_data(outPath= model_RMSEs.csv),
  ),
  # Create a plot
  tar_target(
    figure_1_png,
    create_plot(outPath = "3_visualize_out/figure_1.png", data = eval_data), 
    format = "file"
  ),
  # Save the processed data
  tar_target(
    model_summary_results_csv,
    write_csv(eval_data, outPath = "2_process/out/model_summary_results.csv"), 
    format = "file"
  ),
  # Save the model diagnostics
  tar_target(
    model_diagnostic_text_txt,
    generate_model_diagnostics(outPath = "2_process/out/model_diagnostic_text.txt", data = eval_data), 
    format = "file"
  )
)