# Mackenzie Marti (mmarti-usgs, mmarti@usgs.gov)
#
# This script defines functions related to processing data and saving processed
# data.

library(dplyr)
library(readr)
library(stringr)
library(sbtools)
library(whisker)

# prepare/clean data for plotting
prep_data <- function(data, outPath) {
  mendota_file <- outPath
  readr::read_csv(mendota_file, col_types = 'iccd') %>%
    filter(str_detect(exper_id, 'similar_[0-9]+')) %>%
    mutate(col = case_when(
      model_type == 'pb' ~ '#1b9e77',
      model_type == 'dl' ~'#d95f02',
      model_type == 'pgdl' ~ '#7570b3'
    ), pch = case_when(
      model_type == 'pb' ~ 21,
      model_type == 'dl' ~ 22,
      model_type == 'pgdl' ~ 23
    ), n_prof = as.numeric(str_extract(exper_id, '[0-9]+')))
}


# save processed data
save_processed_data <- function(eval_data, outPath){
  readr::write_csv(eval_data, file = outPath)
}


# save model diagnostics
save_model_diagnostics <- function(eval_data, outPath){
  render_data <- list(pgdl_980mean = filter(eval_data, model_type == 'pgdl', exper_id == "similar_980") %>% pull(rmse) %>% mean %>% round(2),
                      dl_980mean = filter(eval_data, model_type == 'dl', exper_id == "similar_980") %>% pull(rmse) %>% mean %>% round(2),
                      pb_980mean = filter(eval_data, model_type == 'pb', exper_id == "similar_980") %>% pull(rmse) %>% mean %>% round(2),
                      dl_500mean = filter(eval_data, model_type == 'dl', exper_id == "similar_500") %>% pull(rmse) %>% mean %>% round(2),
                      pb_500mean = filter(eval_data, model_type == 'pb', exper_id == "similar_500") %>% pull(rmse) %>% mean %>% round(2),
                      dl_100mean = filter(eval_data, model_type == 'dl', exper_id == "similar_100") %>% pull(rmse) %>% mean %>% round(2),
                      pb_100mean = filter(eval_data, model_type == 'pb', exper_id == "similar_100") %>% pull(rmse) %>% mean %>% round(2),
                      pgdl_2mean = filter(eval_data, model_type == 'pgdl', exper_id == "similar_2") %>% pull(rmse) %>% mean %>% round(2),
                      pb_2mean = filter(eval_data, model_type == 'pb', exper_id == "similar_2") %>% pull(rmse) %>% mean %>% round(2))
  
  template_1 <- 'resulted in mean RMSEs (means calculated as average of RMSEs from the five dataset iterations) of {{pgdl_980mean}}, {{dl_980mean}}, and {{pb_980mean}}°C for the PGDL, DL, and PB models, respectively.
  The relative performance of DL vs PB depended on the amount of training data. The accuracy of Lake Mendota temperature predictions from the DL was better than PB when trained on 500 profiles 
  ({{dl_500mean}} and {{pb_500mean}}°C, respectively) or more, but worse than PB when training was reduced to 100 profiles ({{dl_100mean}} and {{pb_100mean}}°C respectively) or fewer.
  The PGDL prediction accuracy was more robust compared to PB when only two profiles were provided for training ({{pgdl_2mean}} and {{pb_2mean}}°C, respectively). '
  
  whisker.render(template_1 %>% str_remove_all('\n') %>% str_replace_all('  ', ' '), render_data ) %>% cat(file = outPath)
}