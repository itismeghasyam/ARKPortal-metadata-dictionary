server <- function(input, output, session) {

  # load required libraries
  library(shiny)
  library(reactable)
  library(tidyverse)
  
  ## Login into Synapse
  synapser::synLogin()
  
  ## Get Annotations from Synapse
  anno.syn.id <- 'syn50711721'   
  # change synID to final table, currently pointing at tester_proj table
  # 1KD annotation table SynapseID = syn27806892
  annots <- synapser::synTableQuery(paste0('SELECT * FROM ',anno.syn.id))$asDataFrame() %>% 
    dplyr::select(-ROW_ID, -ROW_VERSION, -LeapTerm)
  
  ## Create table to display
  output$annotations_table <- renderReactable({
    reactable(
      annots,
      groupBy = "key",
      searchable = TRUE,
      sortable = TRUE,
      theme = reactable::reactableTheme(
        searchInputStyle = list(width = "100%")
      ),
      columns = list(
        key = colDef(
          name = "Key",
          filterable = TRUE
        ),
        description = colDef(
          name = "Key description",
          aggregate = "unique",
          filterable = TRUE
        ),
        columnType = colDef(
          name = "Type",
          aggregate = "unique",
          filterable = TRUE
        ),
        value = colDef(
          name = "Value",
          aggregate = truncated_values,
          filterable = TRUE
        ),
        valueDescription = colDef(
          name = "Value description",
          aggregate = reactable::JS("function(values, rows) { return '...' }"),
          filterable = TRUE
        ),
        source = colDef(
          name = "Source",
          aggregate = reactable::JS("function(values, rows) { return '...' }"),
          filterable = TRUE
        ),
        module = colDef(
          name = "Module",
          aggregate = "unique",
          filterable = TRUE
        )
      )
    )
  })
}
