## Load packages
suppressPackageStartupMessages(library("dplyr"))
suppressPackageStartupMessages(library("purrr"))
suppressPackageStartupMessages(library("reactable"))
suppressPackageStartupMessages(library("reticulate"))
suppressPackageStartupMessages(library("shiny"))

## Function to truncate display in table
truncated_values <- JS("
  function(values, rows) {
    joined = values.join(', ')
    if (joined.length <= 20) {
      return joined
    }
    return joined.slice(0, 20) + '...'
  }
")
