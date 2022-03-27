### Capacity

The capacity is used when growth is set to 'logistic'. It indicates what the maximum value is that the time series can reach. For product sales, this could be the size of the total market. For a social media platform, this could be the number of internet users.

Here, it needs to be set relative to the historic highest value in the time series, which is indexed at 100. Setting capacity to 150 means that the maximum value is 150% of the previous maximum.

Read more in the <a href="https://facebook.github.io/prophet/docs/saturating_forecasts.html" target="_blank">Prophet docs</a>.
