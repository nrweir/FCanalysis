FCS_expt <- function(x,...) UseMethod('FCS_expt')

FCS_expt.default <- function(directory, sample_names = NULL, is_tFT = TRUE){ #ADD MORE HERE AS DEVELOPS
  
  expt$raw_data <- read_fcs_expt(directory, sample_names)
  
  cleanup <- clean_fc(expt$raw_data)
  expt$clean_data <- cleanup[[1]]
  expt$cleanup_summary <- cleanup[[2]]
  
  
  
  if (is_tFT = TRUE){
    
  }
}