setwd("C:/Users/sondr/Documents/Locker/Skole/Didaktikk - PhD/research projects/kartlegging/analysis") # you'll set this to your directory
source("load_data.R")
source("functions.R")


### HAS HAD VOLUNTARY SUBJECTS ###
table(data$Elective, useNA = "always")

data_pre = data %>%
  filter(GraduateYear %in% c("Før 2020", "2020", "2021 - 2022"))

data_2023 = data %>%
  filter(GraduateYear %in% c("2023"))

data_pre =  data_pre %>%
  filter(IT1 %in% c(TRUE),IT2 %in% c(TRUE))
score_analysis(data_pre)

data_2023 =  data_2023 %>%
  filter(IT1 %in% c(TRUE),IT2 %in% c(TRUE))
score_analysis(data_2023)


t.test(data_pre$Total, data_2023$Total)



mean(data$Total)
sd(data$Total)

# IT1
data_it1_true = data %>%
  filter(IT1 %in% c(TRUE))
score_analysis(data_it1_true)

# IT2
data_it2_true = data %>%
  filter(IT2 %in% c(TRUE))
score_analysis(data_it2_true)

# Prog Mod X
data_X_true = data %>%
  filter(X %in% c(TRUE))
score_analysis(data_X_true)

# Only PMX
data_X_true = data %>%
  filter(X %in% c(TRUE), IT1 %in% c(FALSE),IT2 %in% c(FALSE))
score_analysis(data_X_true)

# Both IT1 and IT2
data_it1_it2 =  data %>%
  filter(IT1 %in% c(TRUE),IT2 %in% c(TRUE))
score_analysis(data_it1_it2)

# Only IT1
data_only_it1 = data %>%
  filter(IT1 %in% c(TRUE),IT2 %in% c(FALSE), X %in% c(FALSE))
score_analysis(data_only_it1)

# Only IT2
data_only_it2 = data %>%
  filter(IT1 %in% c(FALSE), IT2 %in% c(TRUE), X %in% c(FALSE))
score_analysis(data_only_it2)

# IT1 and PMX
data_it1_pmx = data %>%
  filter(IT1 %in% c(TRUE), IT2 %in% c(FALSE), X %in% c(TRUE))
score_analysis(data_it1_pmx)

# All three electives
data_all_three = data %>%
  filter(IT1 %in% c(TRUE),IT2 %in% c(TRUE), X %in% c(TRUE))
score_analysis(data_all_three)

# No electives
data_no_electives = data %>%
  filter(IT1 %in% c(FALSE), IT2 %in% c(FALSE), X %in% c(FALSE))
score_analysis(data_no_electives)

data_no_outside_experience = data_no_electives %>%
  filter(OutsideExperience %in% c("No outside experience"))
score_analysis(data_no_outside_experience)



### No outside experience
data$OutsideTrue = NA
data$OutsideTrue[data$OutsideExperience == "No outside experience"] = FALSE
data$OutsideTrue[is.na(data$OutsideTrue)] = TRUE
table(data$OutsideTrue, useNA = "always")

ggplot(data, aes(x=Total,fill=factor(OutsideTrue))) + 
  geom_histogram(binwidth=1, alpha=0.5, position = 'identity') +
  labs(y= "Frequency", x = "Test score") +
  scale_fill_discrete(labels = c(TRUE, FALSE))

ggplot(data, aes(x=Total,fill=factor(OutsideTrue), y=after_stat(density))) + 
  geom_histogram(boundary = 0, closed = "left", breaks=seq(0, 23, 1), binwidth=1, alpha=0.5, position = 'identity') +
  labs(y= "Frequency", x = "Test score") +
  scale_fill_discrete(labels = c(TRUE, FALSE))+
  scale_y_continuous(labels = scales::percent)


### Electives TRUE FALSE
data$ElectiveTrue = NA
data$ElectiveTrue[data$IT1 == TRUE | data$IT2 == TRUE | data$X == TRUE] = TRUE
data$ElectiveTrue[data$IT1 == FALSE & data$IT2 == FALSE & data$X == FALSE] = FALSE
table(data$ElectiveTrue, useNA = "always")

data_electives = data %>%
  filter(ElectiveTrue %in% c(TRUE))
score_analysis(data_electives)

ggplot(data, aes(x=Total,fill=factor(ElectiveTrue), y=after_stat(density))) + 
  geom_histogram(boundary = 0, closed = "left", breaks=seq(0, 23, 1), binwidth=1, alpha=0.5, position = 'identity') +
  labs(y= "Frequency", x = "Test score") +
  scale_fill_discrete(labels = c(TRUE, FALSE))+
  scale_y_continuous(labels = scales::percent)

wilcox.test(Total~ElectiveTrue, data)




### No outside experience divided by year
data_no_outside_experience$Pre = NA
data_no_outside_experience$Pre[data_no_outside_experience$GraduateYear == "2023"] = TRUE
data_no_outside_experience$Pre[data_no_outside_experience$GraduateYear == "Før 2020" | data_no_outside_experience$GraduateYear == "2020" | data_no_outside_experience$GraduateYear == "2021 - 2022"] = FALSE
table(data_no_outside_experience$Pre, useNA = "always")
table(data_no_outside_experience$GraduateYear, useNA = "always")

score_analysis(data_no_outside_experience)

data_no_outside_experience = data_no_outside_experience %>%
  filter(Pre %in% c(TRUE, FALSE))

ggplot(data_no_outside_experience, aes(x=Total,fill=factor(Pre))) + 
  geom_histogram(binwidth=1, alpha=0.5, position = 'identity') +
  labs(y= "Frequency", x = "Test score") +
  scale_fill_discrete(labels = c(TRUE, FALSE))

ggplot(data_no_outside_experience, aes(x=Total,fill=factor(Pre), y=after_stat(density))) + 
  geom_histogram(boundary = 0, closed = "left", breaks=seq(0, 23, 1), binwidth=1, alpha=0.5, position = 'identity') +
  labs(y= "Frequency", x = "Test score") +
  scale_fill_discrete(labels = c(TRUE, FALSE))+
  scale_y_continuous(labels = scales::percent)

### Wilcox Ranked Sum of pure 2023 vs pre
wilcox.test(Total~Pre, data_no_outside_experience)



data_no_outside_experience_2023 = data_no_electives %>%
  filter(GraduateYear %in% c("2023"))

score_analysis(data_no_outside_experience_2023)

data_no_outside_experience_pre_2023 = data_no_electives %>%
  filter(GraduateYear %in% c("2020", "Før 2020", "2021 - 2022"))

score_analysis(data_no_outside_experience_pre_2023)

ggplot(data_no_outside_experience_2023, aes(x=Total)) + 
  geom_histogram(boundary = 0, closed = "left", breaks=seq(0, 23, 1), fill="#FF9999", color="#e9ecef", alpha=0.9) +
  #scale_y_continuous(labels=scales::percent) +
  labs(y= "Frequency", x = "Test score")





table(data_no_electives$IT1, useNA = "always")
table(data_no_electives$IT2, useNA = "always")
table(data_no_electives$X, useNA = "always")

data_electives = data
data_electives$Elective = NA
data_electives$Elective[data_electives$IT1 == TRUE & data_electives$IT2 == FALSE & data_electives$X == FALSE] = "Only IT1"
data_electives$Elective[data_electives$IT1 == FALSE & data_electives$IT2 == TRUE & data_electives$X == FALSE] = "Only IT2"
data_electives$Elective[data_electives$IT1 == TRUE & data_electives$IT2 == TRUE & data_electives$X == FALSE] = "y IT1+IT2"
data_electives$Elective[data_electives$IT1 == FALSE & data_electives$IT2 == FALSE & data_electives$X == TRUE] = "Only PMX"
data_electives$Elective[is.na(data_electives$Elective)] = "No electives"


table(data_electives$Elective, useNA = "always")


### Violin Plot
#Score plot
ggplot(data_electives, aes(x=Elective, y=(Total/22.6), fill=Elective)) + 
  labs(y= "Score", x = "Elective") +
  scale_y_continuous(labels=scales::percent) +
  
  # geom_violin() function is used to plow violin plot
  geom_violin()+
  
  # Stat_summary() function adds mean marker on plot
  stat_summary(fun.y="mean", geom="point", size=2, color="red") +
  theme(axis.title.x = element_blank()) 


############## DATA ANALYSIS ##############

# QUESTION 1: does ELECTIVE have any relationship with score?

data_elective = data %>%
  filter(Elective %in% c("IT1", "IT2", "PMX"))

model = lm(Elective ~ Total, data = data_elective, na.action = "na.omit")
summary(model)
Anova(model) 

plot_data(data_elective, data_elective$Elective, data_elective$Total)


anova <- aov(AverageAttitude ~ Total*GraduateYear, data = data_year)
summary(anova)

