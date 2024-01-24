setwd("C:/Users/sondr/Documents/Locker/Skole/Didaktikk - PhD/research projects/kartlegging/analysis") # you'll set this to your directory
source("load_data.R")
source("functions.R")


### YEAR OF GRADUATION ###

data_pre = data

# 2023
data_2023 = data %>%
  filter(GraduateYear %in% c("2023"))
score_analysis(data_2023)

# 2021 - 2022
data_2122 = data %>%
  filter(GraduateYear %in% c("2021 - 2022"))
score_analysis(data_2122)

# 2020
data_2020 = data %>%
  filter(GraduateYear %in% c("2020"))
score_analysis(data_2020)

# Before 2020
data_pre2020 = data %>%
  filter(GraduateYear %in% c("Før 2020"))
score_analysis(data_pre2020)

mean(data$Total)
sd(data$Total)

data_pre2023 = data %>%
  filter(GraduateYear %in% c("Før 2020", "2020", "2021 - 2022"))
score_analysis(data_pre2023)

t.test(data_2122$Total, data_pre2020$Total)

data_pre$Pre = NA
data_pre$Pre[data_pre$GraduateYear == "2023"] = TRUE
data_pre$Pre[data_pre$GraduateYear == "Før 2020" | data_pre$GraduateYear == "2020" | data_pre$GraduateYear == "2021 - 2022"] = FALSE
data_pre = data_pre %>%
  filter(Pre %in% c(TRUE, FALSE))
table(data_pre$Pre, useNA = "always")

ggplot(data_pre, aes(x=Total,fill=factor(Pre), y=after_stat(density))) + 
  geom_histogram(boundary = 0, closed = "left", breaks=seq(0, 23, 1), binwidth=1, alpha=0.5, position = 'identity') +
  labs(y= "Frequency", x = "Test score") +
  scale_fill_discrete(labels = c(TRUE, FALSE))+
  scale_y_continuous(labels = scales::percent)

nrow(data_pre)
table(data_pre$Total, useNA = "always")



### Ommit those that do not have Python experience 2023
data_python = data %>%
  filter(GraduateYear %in% c("2023"), LearnedPython %in% c(TRUE))
score_analysis(data_python)

data_no_python = data %>%
  filter(GraduateYear %in% c("2023"), LearnedPython %in% c(FALSE))
score_analysis(data_no_python)



############## DATA ANALYSIS ##############

# QUESTION 1: does GRADUATE YEAR have any relationship with score?

data_year = data %>%
  filter(GraduateYear %in% c("2023", "2021 - 2022", "2020", "Før 2020"))

model = lm(GraduateYear ~ Total, data = data_year, na.action = "na.omit")
summary(model)
Anova(model) 

plot_data(data_year, data_year$GraduateYear, data_year$Total)


anova <- aov(AverageAttitude ~ Total*GraduateYear, data = data_year)
summary(anova)

### Wilcox Ranked Sum of 2023 vs pre
wilcox.test(Total~Pre, data_pre)


############## VIOLIN PLOT ##############

# Alter dataset to have correct order in plots
data_plot = data %>%
  filter(GraduateYear %in% c("2023", "2021 - 2022", "2020", "Før 2020"))

data_plot$GraduateYear[data_plot$GraduateYear == "Før 2020"] = "1 Før 2020"
table(data_plot$GraduateYear, useNA = "always")


#Percentage Plot
ggplot(data_plot, aes(x=GraduateYear, y=(Total/22.6), fill=GraduateYear)) + 
  labs(y= "Score", x = "Graduate Year") +
  scale_y_continuous(labels=scales::percent) +
  
  # geom_violin() function is used to plow violin plot
  geom_violin()+
  
  # Stat_summary() function adds mean marker on plot
  stat_summary(fun.y="mean", geom="point", size=2, color="red") +
  theme(axis.title.x = element_blank()) 


#Percentage Plot
ggplot(data_python, aes(x=GraduateYear, y=(Total/22.6), fill=GraduateYear)) + 
  labs(y= "Score", x = "Graduate Year") +
  scale_y_continuous(labels=scales::percent) +
  
  # geom_violin() function is used to plow violin plot
  geom_violin()+
  
  # Stat_summary() function adds mean marker on plot
  stat_summary(fun.y="mean", geom="point", size=2, color="red") +
  theme(axis.title.x = element_blank()) 