FCS_expt <- function(x,...) UseMethod('FCS_expt')

FCS_expt.default <- function(directory, sample_names = NULL){ #ADD MORE HERE AS DEVELOPS
  
  expt$raw_data <- read_fcs_expt(directory, sample_names)
  
}