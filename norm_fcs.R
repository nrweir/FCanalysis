norm_fcs <- function(data_df){
  # take an FC dataset, generate variables for log-transformed observations, and
  # normalize its fluorescence values to the FSC observation.
  #
  # Args:
  #   data_df: data.frame containing flow cytometry data, extracted from an FCS
  #           file using ReadFCS/read_fcs_expt
  # 
  # Returns:
  #   A data frame containing all data from the original argument along with
  #   variables for normalized data.
  
  # retrieve names of variables and indices of variablescontaining FSC, SSC, 
  # and time observations (if present.)
  var_names <- names(data_df)
  FSC_ind <- grep('FSC', names(data_df))
  SSC_ind <- grep('SSC', names(data_df))
  time_ind <- grep('Time', names(data_df))
  
  
  # generate log-transformed variables
  
  ## 1. remove time variable from the list to log-transform
  if (time_ind != integer(0)){
    var_names <- var_names[!var_names %in% var_names[time_ind]]
  }
  ## 2. generate log-transformed variables
  log_vars <- lapply(var_names, function(x) log10(data_df[grep(x,var_names)]))
  log_var_names <- lapply(var_names, function(x) paste0('log10_',x))
  
  # generate normalized fluorescence variables
  fl_vars <- var_names[!var_names %in% var_names[c(FSC_ind,SSC_ind)]]
  norm_fl_vars <- lapply(fl_vars, function(x) x - log_vars[FSC_ind])
  norm_fl_names <- lapply(fl_vars, function(x) paste0('norm_',x))
  
  # add log-transformed variables and normalized fluorescence variables to the
  # data frame
  new_vars <- c(log_vars,norm_fl_vars)
  new_names <-c(log_var_names,norm_fl_names)
  
  for (i in 1:length(new_vars)){
    data_df[ , new_names[i]] <- new_vars[[i]]
    
  }

  return(data_df)
}