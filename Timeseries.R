library(readxl)
library(forecast)
library(tseries)
library(xts)

# Read the list of filenames from complete.txt
file_list <- readLines("C:\\Users\\chaud\\Music\\Project\\Project_timeseries\\Timeseries_return\\alpha_familywise_comparison.txt")
file_list
# Create an empty data frame to store results
results <- data.frame(filename = character(),
                      fit = character(),
                      adf_test_statistic = numeric(),
                      adf_test_p_value = numeric(),
                      kpss_test_statistic = numeric(),
                      kpss_test_p_value = numeric(),
                      stringsAsFactors = FALSE)

# Iterate over each file
for (filename in file_list) {
  # Construct the full path of the CSV file
  file_path <- paste("C:\\Users\\chaud\\Music\\Project\\Project_timeseries\\Timeseries_return\\alpha_mapped\\", filename, sep="")
  print(file_path)
  # Read the CSV file
  D1 <- read.csv(file_path)
  
  # Check if the data frame is empty or Potential column is missing
  if (ncol(D1) == 0 || is.null(D1$Potential)) {
    warning(paste("No data or 'Potential' column missing in file:", filename))
    next  # Skip to the next iteration
  }
  
  # Check if there are observations in the data
  if (nrow(D1) == 0) {
    warning(paste("No observations in file:", filename))
    next  # Skip to the next iteration
  }
  
  # Extract the column 'Potential'
  pt <- ts(D1$Potential, frequency = 6) # use freq 6 for alpha and 5 for beta
  
  # Decompose the time series
  dec <- decompose(pt)
  
  # Plot the decomposition
  png(paste0(filename, "_decomposition.png"))
  plot(dec)
  dev.off()
  
  # Plot ACF
  png(paste0(filename, "_acf.png"))
  acf(pt)
  dev.off()
  
  # Plot PACF
  png(paste0(filename, "_pacf.png"))
  pacf(pt)
  dev.off()
  
  # Fit auto.arima model
  fit <- auto.arima(pt)
  
  # Test for stationarity
  adf_test <- adf.test(pt)
  kpss_test <- kpss.test(pt)
  
  # Save results to data frame
  results <- rbind(results, data.frame(filename = filename,
                                       fit = as.character(fit),
                                       adf_test_statistic = adf_test$statistic,
                                       adf_test_p_value = adf_test$p.value,
                                       kpss_test_statistic = kpss_test$statistic,
                                       kpss_test_p_value = kpss_test$p.value,
                                       stringsAsFactors = FALSE))
}
results
# Save results to CSV
write.csv(results, "C:\\Users\\chaud\\Music\\Project\\Project_timeseries\\Timeseries_return\\Results\\results_alpha6_fam.csv", row.names = FALSE)

