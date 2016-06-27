read_fcs_expt <- function(directory){
  # Load a set of multiple FCS files into the R workspace.
  #
  # Args:
  #   directory: The file directory containing the desired FCS files. All FCS
  #             files at this directory will be loaded.
  #   sample_names: *TO BE IMPLEMENTED IN A FUTURE VERSION* Will retrieve
  #                 sample names from some type of R object or file to match
  #                 them to samples.
  #
  # Returns:
  #   A data frame with all data from the samples, with variable names for each
  #   sample contained in the first column of the frame.
  
  require(plyr)
  require(readr)
  require(dplyr)
  source("~/Dropbox/Lab_Notebook/R_code/FC/ReadFCS.R")
  
  file_v <- list.files(path = directory, pattern = '.fcs')
  file_v <- lapply(file_v,function(x) paste0(directory,'/',x)) #add path
  sample_name_file <- list.files(path = directory, pattern = '.csv') 
 
  if (length(sample_name_file) == 1){
    name_df <- read_csv(paste0(directory,'/',sample_name_file[1]), col_names = TRUE)
  }else if (length(sample_name_file) == 0){
    warning('No sample name reference file found.')
  }else{
    warning('Unique sample name reference file not found.')}
  
  
  data_ls <- lapply(file_v,ReadFCS)
  #remaking a more 'r-native' implementation of steps of adding sample name and replicate columns
  #function to add sample names and replicate names:
  sam_and_rep_names <- function(well_data, name_frame){
    well_data$sample_name <- rep(name_frame$SAMPLE[name_frame$WELL == well_data$sample_ID[1]],
                                 length(well_data$sample_ID))
    well_data$replicate <- rep(name_frame$REP[name_frame$WELL == well_data$sample_ID[1]],
                               length(well_data$sample_ID))
    return(well_data)
  }
  
  if (exists('name_df')){
    data_ls <- lapply(data_ls, sam_and_rep_names, name_frame = name_df)
  }
  
#   for (i in 1:length(file_v)){
#     
#     data_ls[[i]] <- ReadFCS(paste0(directory,'/',file_v[i]))
#     
#     
#     file_df$sample_name <- NA
#     file_df$replicate <- NA
#     
# 
#     file_df$sample_name <- rep(name_df$SAMPLE[name_df$WELL == file_df$sample_ID[1]],
#                                length(file_df$sample_ID))
#     file_df$replicate <- rep(name_df$REP[name_df$WELL == file_df$sample_ID[1]],
#                                 length(file_df$sample_ID))
#     
#     data_ls[[i]] <- file_df
#     
#     print(paste0(i,' of ',length(file_v),' fcs files loaded'))
#   }
  
  print('merging...')
  expt_df <- bind_rows(data_ls)
  
  print('read_fcs_expt completed')
  return(expt_df)
}