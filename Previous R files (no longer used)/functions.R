score_analysis <- function(data, graduateYear=0) {
  if (graduateYear == 2) {
    data_analysis= data %>%
      filter(GraduateYear %in% c("2023"))
  }
  else if (graduateYear == 1){
    data_analysis= data %>%
      filter(GraduateYear %in% c("2021 - 2022", "2020", "Før 2020"))
  }
  else {
    data_analysis = data
  }
  print("N:")
  n = length(data_analysis$Total)
  print(n)
  
  print("Mean:")
  mean = mean(data_analysis$Total)
  print(mean)
  
  print("Standard Diviation:")
  sd = sd(data_analysis$Total)
  print(sd)
}

plot_data <- function(data, x, y) {
  data %>%
    ggplot(aes(x = x, y = y))+
    geom_point(position = position_jitter(seed = 1, width = 0.1))+
    ylab("x")+
    xlab("y")+
    theme_bw()
}