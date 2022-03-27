ui <- fluidPage(
  theme = bs_theme(bootswatch = "minty"),
  useWaiter(),
  waiterPreloader(html = waiter_html, color = waiter_color),
  titlePanel("Forecasting with Prophet"),
  sidebarLayout(
    sidebarPanel(
      tags$h4("Settings"),
      helpText("Press the '?' symbols to learn more about each setting"),
      selectInput(
        inputId = "timeseries",
        label = "Time series",
        choices = ts_choices
      ) %>%
        helper(content = "timeseries"),
      sliderInput(
        inputId = "future_periods",
        label = "Forecast horizon (months)",
        min = 1,
        max = 60,
        value = 12
      ) %>% 
        helper(content = "future_periods"),
      radioButtons(
        inputId = "growth",
        label = "Growth",
        choices = c(
          "Linear" = "linear", 
          "Logistic" = "logistic",
          "Flat" = "flat"
        ),
        inline = TRUE
      ) %>% helper(content = "growth"),
      conditionalPanel(
        condition = "input.growth == 'logistic'",
        numericInput(
          inputId = "capacity",
          label = "Capacity",
          value = 150,
          min = 100,
          step = 5
        )
      ) %>% helper(content = "capacity"),
      checkboxInput(
        inputId = "seasonality",
        label = "Yearly seasonality",
        value = TRUE
      ) %>% helper(content = "seasonality"),
      radioButtons(
        inputId = "seasonality_mode",
        label = "Seasonality mode",
        choices = c(
          "Additive" = "additive",
          "Multiplicative" = "multiplicative"
        ),
        inline = TRUE
      ) %>% helper(content = "seasonality_mode"),
      tags$hr(),
      checkboxInput(
        inputId = "expert_mode",
        label = "Show additional settings",
        value = FALSE
      ),
      conditionalPanel(
        condition = "input.expert_mode",
        sliderInput(
          inputId = "n_changepoints",
          label = "Number of changepoints",
          min = 1, 
          max = 100,
          value = 25
        ) %>% helper(content = "n_changepoints"),
        sliderInput(
          inputId = "changepoint_range",
          label = "Changepoint range",
          min = 0,
          max = 1,
          value = 0.8,
          step = 0.01
        ) %>% helper(content = "changepoint_range"),
        numericInput(
          inputId = "seasonality_prior_scale",
          label = "Seasonality prior scale",
          value = 10,
          step = 1
        ) %>% helper(content = "seasonality_prior_scale"),
        numericInput(
          inputId = "changepoint_prior_scale",
          label = "Changepoint prior scale",
          value = 0.05,
          step = 0.01
        ) %>% helper(content = "changepoint_prior_scale"),
        sliderInput(
          inputId = "interval_width",
          label = "Uncertainty interval width",
          min = 0,
          max = 1,
          value = 0.8,
          step = 0.01
        ) %>% helper(content = "interval_width"),
      )
    ),
    mainPanel(
      dygraphOutput("prophet_plot", height = "600px"),
      tags$br(),
      includeMarkdown("helpfiles/uitext.md")
    )
  )
)
