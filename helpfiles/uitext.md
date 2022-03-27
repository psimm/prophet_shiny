This app demonstrates the <a href="http://facebook.github.io/prophet/" target="_blank">Prophet</a> time series forecasting algorithm. Use it to learn more about its settings and how they influence the forecasts. If you're new to Prophet, this <a href="https://www.youtube.com/watch?v=eJrbKU09h-0" target="_blank">explainer video</a> is a great place to start.

Additional settings are available with the `prophet` function in R and Python. Specifically, this app does not allow specifying individual holiday effects or finer points of the Monte Carlo method.

The time series were collected from Google Trends on March 26, 2022 using the <a href="https://github.com/PMassicotte/gtrendsR" target="_blank">gtrendsR</a> package. Google Trends indicates the volume of Google searches for a search term. The values are indexed to the period with the highest search volume. Comparisons between search terms are not possible, only within each time series.

The R code for this app is available at <a href="https://github.com/psimm/prophet_shiny" target="_blank">github.com/psimm/prophet_shiny</a>.
