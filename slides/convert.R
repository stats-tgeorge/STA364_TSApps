# Load necessary library
library(yaml)

# Function to convert RMD to QMD
convert_rmd_to_qmd <- function(input_file, output_file) {
  # Read the RMD file
  lines <- readLines(input_file)
  
  # Find the YAML header
  yaml_start <- grep("^---$", lines)[1]
  yaml_end <- grep("^---$", lines)[2]
  
  # Extract and modify the YAML header
  yaml_header <- yaml.load(paste(lines[(yaml_start + 1):(yaml_end - 1)], collapse = "\n"))
  yaml_header$output <- NULL
  yaml_header$format <- "html"
  
  # Convert the modified YAML header back to text
  new_yaml <- as.yaml(yaml_header)
  
  # Create the new QMD content
  new_content <- c("---", new_yaml, "---", lines[(yaml_end + 1):length(lines)])
  
  # Write the new QMD file
  writeLines(new_content, output_file)
}

# Example usage
convert_rmd_to_qmd("your-document.Rmd", "your-document.qmd")