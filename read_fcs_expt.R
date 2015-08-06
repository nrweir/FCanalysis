read_fcs_expt <- function(directory, sample_names = NULL){
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
  
  file_v <- list.files(path = directory, pattern = '.fcs')
  
  
  for (i in 1:file_v){
    
    file_df <- ReadFCS(file_v[i])
    
    if (is.null(sample_names)){
      file_df$sample_name <- file_v[i]
      file_df$replicate <- NA
    }
    
#TODO: IMPLEMENT SAMPLE_NAMES
    if (!exists(expt_df)){
      expt_df <- file_df
    }else{
      rbind(expt_df,file_df)
    }
  }
  
  return(expt_df)
}