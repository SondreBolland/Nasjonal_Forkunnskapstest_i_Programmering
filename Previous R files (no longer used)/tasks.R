setwd("C:/Users/sondr/Documents/Locker/Skole/Didaktikk - PhD/research projects/kartlegging/analysis") # you'll set this to your directory
source("load_data.R")
source("functions.R")


data = data %>%
  filter(GraduateYear %in% c("2023"))

### SCORE BY PROGRAMMING CONCEPT ###
print("Total score. Max: 22.6")
total_max = 22.6
mean_total = mean(data$Total)
mean_total
total_percentage = (mean_total / total_max) * 100
total_percentage
sd(data$Total)

print("Datatypes. Max: 2.2")
datatypes_max = 2.2
mean_datatypes = mean(data$datatypes)
mean_datatypes
datatypes_percentage = (mean_datatypes / datatypes_max) * 100
datatypes_percentage

print("Variables. Max: 2")
variables_max = 2
mean_variables = mean(data$variables)
mean_variables
variables_percentage = (mean_variables / variables_max) * 100
variables_percentage

print("Bool Max: 3.4")
bool_max = 3.4
mean_bool = mean(data$bool)
mean_bool
bool_percentage = (mean_bool / bool_max) * 100
bool_percentage

print("Conditionals. Max: 3")
conditionals_max = 3
mean_conditionals = mean(data$conditionals)
mean_conditionals
conditionals_percentage = (mean_conditionals / conditionals_max) * 100
conditionals_percentage

print("Loops. Max: 2")
loops_max = 2
mean_loops = mean(data$loops)
mean_loops
loops_percentage = (mean_loops / loops_max) * 100
loops_percentage

print("Lists. Max: 3")
lists_max = 3
mean_lists = mean(data$lists)
mean_lists
lists_percentage = (mean_lists / lists_max) * 100
lists_percentage

print("Functions. Max: 6")
functions_max = 7
mean_functions = mean(data$functions)
mean_functions_part = mean(data$functions_part)
mean_functions
functions_percentage = ((mean_functions + mean_functions_part) / functions_max) * 100
functions_percentage

