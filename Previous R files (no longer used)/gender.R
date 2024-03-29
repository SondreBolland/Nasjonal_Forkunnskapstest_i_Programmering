setwd("C:/Users/sondr/Documents/Locker/Skole/Didaktikk - PhD/research projects/kartlegging/analysis") # you'll set this to your directory
source("load_data.R")
source("functions.R")


### GENDER ###
data_year = data %>%
  filter(GraduateYear %in% c("2021 - 2022", "2020", "Pre 2020"))
data_year = data %>%
  filter(GraduateYear %in% c("2023"))
table(data_year$Gender, useNA = "always")

data_gender = data %>%
  filter(Gender %in% c("m", "f"))
table(data_gender$Gender, useNA = "always")

data_male = data %>%
  filter(Gender %in% c("m"))

data_female = data %>%
  filter(Gender %in% c("f"))


score_analysis(data_gender)
score_analysis(data_male)
score_analysis(data_female)

t.test(data_male$Total, data_female$Total)

### Electives

# Male
table(data_male$IT1, useNA = "always")
table(data_male$IT2, useNA = "always")
table(data_male$X, useNA = "always")

data_male_no_electives = data_male %>%
  filter(IT1 %in% c(FALSE), IT2 %in% c(FALSE), X %in% c(FALSE))
score_analysis(data_male_no_electives)

# Female
table(data_female$IT1, useNA = "always")
table(data_female$IT2, useNA = "always")
table(data_female$X, useNA = "always")

data_female_no_electives = data_female %>%
  filter(IT1 %in% c(FALSE), IT2 %in% c(FALSE), X %in% c(FALSE))
score_analysis(data_female_no_electives)

# Both
data_gender_no_electives = data_gender %>%
  filter(IT1 %in% c(FALSE), IT2 %in% c(FALSE), X %in% c(FALSE))
score_analysis(data_gender_no_electives)

### Outside experience

# Male
data_male_ouside = data_male %>%
  filter(OutsideExperience %in% c("30 hour text", "50 hour text", "100 hour text", "120 hour text", "30 hour block", "50 hour block", "100 hour block", "120 hour block"))
score_analysis(data_male_ouside)

# Female
data_female_ouside = data_female %>%
  filter(OutsideExperience %in% c("30 hour text", "50 hour text", "100 hour text", "120 hour text", "30 hour block", "50 hour block", "100 hour block", "120 hour block"))
score_analysis(data_female_ouside)

# Both
data_gender_ouside = data_gender %>%
  filter(OutsideExperience %in% c("30 hour text", "50 hour text", "100 hour text", "120 hour text", "30 hour block", "50 hour block", "100 hour block", "120 hour block"))
score_analysis(data_gender_ouside)

### MATH COURSES

# Male
table(data_male$P1, useNA = "always")
table(data_male$P2, useNA = "always")
table(data_male$T1, useNA = "always")
table(data_male$S1, useNA = "always")
table(data_male$S2, useNA = "always")
table(data_male$R1, useNA = "always")
table(data_male$R2, useNA = "always")

data_male_R1 = data_male %>%
  filter(R2 %in% c(FALSE))
table(data_male_R1$R1, useNA = "always")

  # Female
table(data_female$P1, useNA = "always")
table(data_female$P2, useNA = "always")
table(data_female$T1, useNA = "always")
table(data_female$S1, useNA = "always")
table(data_female$S2, useNA = "always")
table(data_female$R1, useNA = "always")
table(data_female$R2, useNA = "always")

data_female_R1 = data_female %>%
  filter(R2 %in% c(FALSE))
table(data_female_R1$R1, useNA = "always")


### R2 students without electives or outside experience

# Male
data_male_R2_no_electives = data_male_no_electives %>%
  filter(R2 %in% c(TRUE))

data_male_only_math = data_male_R2_no_electives %>%
  filter(OutsideExperience %in% c("No outside experience"))
score_analysis(data_male_only_math)

# Check for normality
shapiro.test(data_male_only_math$Total)

ggplot(data_male_only_math, aes(x=Total)) + 
  geom_histogram(binwidth=1, fill="#FF9999", color="#e9ecef", alpha=0.9) +
  #scale_y_continuous(labels=scales::percent) +
  labs(y= "Frequency", x = "Test score")

# Female
data_female_R2_no_electives = data_female_no_electives %>%
  filter(R2 %in% c(TRUE))

data_female_only_math = data_female_R2_no_electives %>%
  filter(OutsideExperience %in% c("No outside experience"))
score_analysis(data_female_only_math)

# Check for normality
shapiro.test(data_female_only_math$Total)

ggplot(data_female_only_math, aes(x=Total)) + 
  geom_histogram(binwidth=1, fill="#FF9999", color="#e9ecef", alpha=0.9) +
  #scale_y_continuous(labels=scales::percent) +
  labs(y= "Frequency", x = "Test score")

# Both
data_gender_R2_no_electives = data_gender_no_electives %>%
  filter(R2 %in% c(TRUE))

data_gender_only_math = data_gender_R2_no_electives %>%
  filter(OutsideExperience %in% c("No outside experience"))
score_analysis(data_gender_only_math)


ggplot(data_gender_only_math, aes(x=Total,fill=factor(Gender))) + 
  geom_histogram(binwidth=1, alpha=0.5, position = 'identity') +
  labs(y= "Frequency", x = "Test score") 
  #scale_fill_discrete(labels = c(TRUE, FALSE))

ggplot(data, aes(x=Sem1,fill=factor(Semester))) + 
  geom_histogram(binwidth=1, alpha=0.5, position = 'identity') +
  labs(y= "n", x = "Score")
#scale_fill_discrete(labels = c("Voluntary", "Mandatory"))



### STATISTICAL DIFFERENCE
wilcox.test(Total~Gender, data_gender_only_math)



### Violin Plot
#Score plot
ggplot(data_gender_only_math, aes(x=Gender, y=(Total/22.6), fill=Gender)) + 
  labs(y= "Score", x = "Gender") +
  scale_y_continuous(labels=scales::percent) +
  
  # geom_violin() function is used to plow violin plot
  geom_violin()+
  
  # Stat_summary() function adds mean marker on plot
  stat_summary(fun.y="mean", geom="point", size=2, color="red") +
  theme(axis.title.x = element_blank()) 

