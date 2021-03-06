ReadFCS <- function(path){
  # Loads an FCS file as a data.frame with measurements as headers.
  #
  # Args:
  #   path: The file path containing the FCS file to be read.
  #
  # Returns:
  #   A data.frame with columns being the different measured parameters and 
  #   rows being individual measured events.
  
  require(flowCore)
  
  sample_ff <- read.FCS(path) # returns initial flowFrame object to reshape
  sample_df <- data.frame(exprs(sample_ff))
  sample_df$sample_ID <- description(sample_ff)$'TUBE NAME'
  
  return(sample_df)
}