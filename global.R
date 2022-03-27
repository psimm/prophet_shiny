library(shiny)
library(shinyhelper)
library(waiter)
library(bslib)
library(prophet)
library(dygraphs)
library(markdown)

# Set cache size, used by bindCache()
shinyOptions(cache = cachem::cache_mem(max_size = 300e6))

# Load dataset choices
ts_choices <- readRDS("data/ts_choices.RDS")

# Define theme for waiter
waiter_html <- spin_wave()
waiter_color <- "#78c2ad"
