server <- function(input, output) {
  observe_helpers()
  
  data <- reactive({
    readRDS(file = paste0("data/", input$timeseries, ".RDS"))
  }) %>% 
    bindCache(input$timeseries)
  
  model <- reactive({
    waiter_show(id = "prophet_plot", html = waiter_html, color = waiter_color)
    
    # Add the capacity
    history <- data()
    history$cap <- input$capacity
    
    # Fit a prophet model
    prophet(
      df = history, 
      growth = input$growth,
      n.changepoints = input$n_changepoints,
      seasonality.mode = input$seasonality_mode,
      changepoint.range = input$changepoint_range,
      yearly.seasonality = input$seasonality,
      weekly.seasonality = FALSE,
      daily.seasonality = FALSE,
      seasonality.prior.scale = input$seasonality_prior_scale,
      changepoint.prior.scale = input$changepoint_prior_scale,
      interval.width = input$interval_width
    )
  }) %>% 
    bindCache(
      data(), 
      input$capacity,
      input$growth, 
      input$n_changepoints, 
      input$seasonality_mode,
      input$changepoint_range,
      input$seasonality,
      input$seasonality_prior_scale,
      input$holidays_prior_scale,
      input$changepoint_prior_scale,
      input$interval_width
    )
  
  forecast <- reactive({
    waiter_show(id = "prophet_plot", html = waiter_html, color = waiter_color)
    
    future <- make_future_dataframe(
      m = model(),
      periods = input$future_periods,
      freq = "month",
      include_history = TRUE
    )
    future$cap <- input$capacity
    
    predict(model(), future)
  }) %>% 
    bindCache(model(), input$future_periods)
  
  output$prophet_plot <- renderDygraph({
    dy <- dyplot.prophet(
      x = model(),
      fcst = forecast(),
      uncertainty = TRUE,
      main = paste(
        "Prophet forecast for", 
        names(ts_choices)[ts_choices == input$timeseries] # Current series name
      ),
      ylab = "Google Searches (indexed)"
    ) %>% 
      dyCSS("www/dygraphs.css") %>% 
      dyOptions(
        colors = c("black", waiter_color),
        pointSize = 2,
        strokeWidth = 2
      )
    waiter_hide(id = "prophet_plot")
    dy
  }) %>% 
    bindCache(model(), forecast())
}
