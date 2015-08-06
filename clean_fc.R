clean_fc <- function(fcs_expt){
  # Removes all observations containing negative values from an FC experiment.
  #
  # Args: fcs_expt: data.frame created by read_fcs_expt containing concatenated
  #                 .fcs files in a single data.frame.
  #
  # Returns: list(clean_expt, clean_summary) 
  #         clean_expt: a data.frame with all observations containing negative 
  #                   values removed from the data.frame 
  #         clean_summary: a frame with the variable names matched to the fraxn
  #                   of observations that remain after cleaning, and the # of
  #                   observations that were removed
  
  # check argument
  require(plyr)
  
  if (class(fcs_expt) != 'data.frame'){
    stop('Error in clean_FC: data input not in data.frame format')
  }
  
  clean_expt <- fcs_expt
  clean_expt[clean_expt < 1] <- NA
  clean_expt[complete.cases(clean_expt)]
  
  counts <- lapply(list(clean_expt, fcs_expt), count, 
}