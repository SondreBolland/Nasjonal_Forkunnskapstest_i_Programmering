setwd("C:/Users/sondr/Documents/Locker/Skole/Didaktikk - PhD/research projects/kartlegging/analysis") # you'll set this to your directory
source("load_data.R")
source("functions.R")


attitude = data %>%
  select("AttitudeInterest", "AttitudeWork",	"AttitudeEnjoyment", "AttitudeEffort","AttitudeStudies")
alpha(attitude)

data$AverageAttitude = NA
data$AverageAttitude = rowMeans(data[, c("AttitudeInterest", "AttitudeWork",	"AttitudeEnjoyment", "AttitudeEffort","AttitudeStudies")], 
                                       na.rm = TRUE)
mean(data$AverageAttitude, na.rm = T)
sd(data$AverageAttitude, na.rm = T)

############## DATA ANALYSIS ##############


# QUESTION 1: does ATTITUDE have any relationship with score?

model = lm(AverageAttitude ~ Total, data = data, na.action = "na.omit")
summary(model)
Anova(model) 

data %>%
  ggplot(aes(x = AverageAttitude, y = Total))+
  geom_point(position = position_jitter(seed = 1, width = 0.1))+
  ylab("Attitude")+
  xlab("Mean score")+
  theme_bw()


data %>%
  ggplot(aes(x = Total, y = AverageAttitude))+
  geom_point(position = position_jitter(seed = 1, width = 0.1))+
  ylab("Sense of Belonging")+
  xlab("Binary Gender")+
  theme_bw()

# Random effect from GraduateYear
model_RE = lmer(AverageAttitude ~ Total + (1|GraduateYear), 
                na.action = na.omit, data = data)
summary(model_RE)
Anova(model_RE, type = 3)


anova <- aov(AverageAttitude ~ Total*GraduateYear, data = data)
summary(anova)


### PLOT

ggplot(attitude, aes(x=AttitudeInterest)) +
  geom_bar(aes(fill=Answer))

plot_likert(attitude)