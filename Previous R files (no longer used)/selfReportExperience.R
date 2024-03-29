setwd("C:/Users/sondr/Documents/Locker/Skole/Didaktikk - PhD/research projects/kartlegging/analysis") # you'll set this to your directory
source("load_data.R")
source("functions.R")

### Learned Python programming

# Experience
#data_experience_true = data %>%
#  filter(LearnedPython %in% c(TRUE))

# Experience
data_experience_true = data %>%
  filter(LearnedPython %in% c("aGraduated before 2023"))

score_analysis(data_experience_true)
score_analysis(data_experience_true, 1)
score_analysis(data_experience_true, 2)

# No experience
data_experience_false = data %>%
  filter(LearnedPython %in% c(FALSE))

score_analysis(data_experience_false)
score_analysis(data_experience_false, 1)
score_analysis(data_experience_false, 2)

### Outside experience
data_text_experience = data %>%
  filter(OutsideExperience %in% c("30 hour text", "50 hour text", "100 hour text", "120 hour text"))

score_analysis(data_text_experience)
score_analysis(data_text_experience, 1)
score_analysis(data_text_experience, 2)

data_block_experience = data %>%
  filter(OutsideExperience %in% c("30 hour block", "50 hour block", "100 hour block", "120 hour block"))

score_analysis(data_block_experience)
score_analysis(data_block_experience, 1)
score_analysis(data_block_experience, 2)

data_experience = data %>%
  filter(OutsideExperience %in% c("30 hour block", "50 hour block", "100 hour block", "120 hour block", "30 hour text", "50 hour text", "100 hour text", "120 hour text"))
score_analysis(data_experience)



data_no_outside_experience = data %>%
  filter(OutsideExperience %in% c("No outside experience"))
score_analysis(data_no_outside_experience)

# No outside
ggplot(data_no_outside_experience, aes(x=Total)) + 
  geom_histogram(boundary = 0, closed = "left", breaks=seq(0, 23, 1), fill="#FF9999", color="#e9ecef", alpha=0.9) +
  #scale_y_continuous(labels=scales::percent) +
  labs(y= "Frequency", x = "Test score")




############## DATA ANALYSIS ##############

# QUESTION 1: does GRADUATE YEAR have any relationship with score?

data_python = data %>%
  filter(LearnedPython %in% c(TRUE, FALSE))

model = lm(LearnedPython ~ Total, data = data_python, na.action = "na.omit")
summary(model)
Anova(model) 

plot_data(data_python, data_python$LearnedPython, data_python$Total)

### Violin Plot
#Score plot
ggplot(data, aes(x=LearnedPython, y=(Total/22.6), fill=LearnedPython)) + 
  labs(y= "Score", x = "Programming") +
  scale_y_continuous(labels=scales::percent) +
  
  # geom_violin() function is used to plow violin plot
  geom_violin()+
  
  # Stat_summary() function adds mean marker on plot
  stat_summary(fun.y="mean", geom="point", size=2, color="red") +
  theme(axis.title.x = element_blank()) 