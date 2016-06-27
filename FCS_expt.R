FCS_expt <- function(x,...) UseMethod('FCS_expt')

FCS_expt.default <- function(directory, is_tFT = TRUE){ #ADD MORE HERE AS DEVELOPS
  
  source('~/Dropbox/Lab_Notebook/R_code/FC/clean_fc.R')
  source('~/Dropbox/Lab_Notebook/R_code/FC/read_fcs_expt.R')
  source('~/Dropbox/Lab_Notebook/R_code/FC/add_tFT_ratio.R')
  source('~/Dropbox/Lab_Notebook/R_code/FC/density_FCS_expt.R')
  source('~/Dropbox/Lab_Notebook/R_code/FC/label_wells.R')
  source('~/Dropbox/Lab_Notebook/R_code/FC/norm_fcs.R')
  
  expt <- list(raw_data = read_fcs_expt(directory))
  print('call cleanup')
  cleanup <- clean_fc(expt$raw_data)
  expt$clean_data <- cleanup[[1]]
  expt$cleanup_summary <- cleanup[[2]]
  
  expt$raw_data <- norm_fcs(expt$raw_data)
  expt$clean_data <- norm_fcs(expt$clean_data)
  
  if (is_tFT == TRUE){
    expt$clean_data <- add_tFT_ratio(expt$clean_data)
  }
  class(expt) <- 'FCS_expt'
  
  return(expt)
}

