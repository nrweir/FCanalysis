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
  
  print('clean_fc initialized')
  
  # check argument
  require(plyr)
  
  if (!is.data.frame(fcs_expt)){
    stop('Error in clean_FC: data input not in data.frame format')
  }
  
  clean_expt <- fcs_expt
  clean_expt[clean_expt < 1] <- NA
  clean_expt[clean_expt == 262143] <- NA
  if (exists('fcs_expt$sample_name')){
    clean_expt$sample_name <- fcs_expt$sample_name}
  if (exists('fcs_expt$replicate')){
    clean_expt$replicate[is.na(clean_expt$replicate)] <- 0}
  clean_expt <- clean_expt[complete.cases(clean_expt[ ,1:ncol(clean_expt)]), ]
  
  counts <- (lapply(list(clean_expt$sample_name, fcs_expt$sample_name), table))
  counts_frame <- data.frame(clean_expt = data.frame(counts[[1]])$Freq, 
                             raw_expt = data.frame(counts[[2]])$Freq)
  clean_summary <- data.frame(sample_names = data.frame(counts[[1]])$Var1, 
                              frac_retained = sweep(counts_frame,1,counts_frame$raw_expt,FUN = '/')$clean_expt,
                              obs_removed = sweep(counts_frame,1,counts_frame$clean_expt)$raw_expt)
  print(clean_summary)
  
  print('clean_fc completed')
  return(list(clean_expt = clean_expt,clean_summary = clean_summary))
  

}