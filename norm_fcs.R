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
  print('begin norm_fcs')
  
  var_names <- names(data_df)
  
  
  # generate log-transformed variables
  
  ## 2. generate log-transformed variables
  to_xform <- lapply(data_df,is.numeric)
  to_xform$replicate <- NULL
  log_vars <- lapply(data_df[as.logical(to_xform)], log10)
  log_var_names <- lapply(var_names[as.logical(to_xform)], function(x) paste0('log10_',x))
  
  # generate normalized fluorescence variables
  fl_vars <- log_vars[as.logical(to_xform)]
  fl_vars$FSC.A <- NULL
  fl_vars$SSC.A <- NULL
  norm_fl_vars <- lapply(fl_vars, function(x) x - log_vars$FSC.A)
  norm_fl_names <- lapply(names(fl_vars), function(x) paste0('norm_',x))
  
  # add log-transformed variables and normalized fluorescence variables to the
  # data frame
  new_vars <- c(log_vars,norm_fl_vars)
  new_names <-c(log_var_names,norm_fl_names)
  
  for (i in 1:length(new_vars)){
    data_df[ , new_names[[i]]] <- new_vars[[i]]
    
  }
  print('norm_fcs completed.')
  return(data_df)
}