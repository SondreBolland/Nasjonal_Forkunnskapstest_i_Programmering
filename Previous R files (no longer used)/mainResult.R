setwd("C:/Users/sondr/Documents/Locker/Skole/Didaktikk - PhD/research projects/kartlegging/analysis") # you'll set this to your directory
source("load_data.R")
source("functions.R")

summary(data$Total)
sd(data$Total)
nrow(data)

data_pre = data %>%
  filter(GraduateYear %in% c("Før 2020", "2020", "2021 - 2022"))

data_2023 = data %>%
  filter(GraduateYear %in% c("2023"))

data_no_electives = data_pre %>%
  filter(IT1 %in% c(FALSE), IT2 %in% c(FALSE), X %in% c(FALSE))
summary(data_no_electives$Total)
nrow(data_no_electives)
score_analysis(data_no_electives)


data_no_electives_2023 = data_no_electives %>%
  filter(GraduateYear %in% c("2023"))
summary(data_no_electives_2023$Total)
nrow(data_no_electives_2023)
score_analysis(data_no_electives_2023)

shapiro.test(data$Total)
ggqqplot(data$Total)

qnorm(0.975)

# All
ggplot(data, aes(x=Total)) + 
  geom_histogram(boundary = 0, closed = "left", breaks=seq(0, 23, 1), fill="#FF9999", color="#e9ecef", alpha=0.9) +
  #scale_y_continuous(labels=scales::percent) +
  labs(y= "Frequency", x = "Test score")

ggplot(data, aes(x=Total,fill=factor(Pre))) + 
  geom_histogram(boundary = 0, closed = "left", breaks=seq(0, 23, 1), binwidth=1, alpha=0.5, position = 'identity') +
  labs(y= "Frequency", x = "Test score") +
  scale_fill_discrete(labels = c(TRUE, FALSE))+

# Pre 2023
ggplot(data_pre, aes(x=Total)) + 
  geom_histogram(boundary = 0, closed = "left", breaks=seq(0, 23, 1), fill="#FF9999", color="#e9ecef", alpha=0.9) +
  #scale_y_continuous(labels=scales::percent) +
  labs(y= "Frequency", x = "Test score")

# 2023
ggplot(data_2023, aes(x=Total)) + 
  geom_histogram(boundary = 0, closed = "left", breaks=seq(0, 23, 1), fill="#FF9999", color="#e9ecef", alpha=0.9) +
  #scale_y_continuous(labels=scales::percent) +
  labs(y= "Frequency", x = "Test score")

# No electives
ggplot(data_no_electives, aes(x=Total)) + 
  geom_histogram(boundary = 0, closed = "left", breaks=seq(0, 23, 1), fill="#FF9999", color="#e9ecef", alpha=0.9) +
  #scale_y_continuous(labels=scales::percent) +
  labs(y= "Frequency", x = "Test score")


# No electives 2023
ggplot(data_no_electives_2023, aes(x=Total)) + 
  geom_histogram(boundary = 0, closed = "left", breaks=seq(0, 23, 1), fill="#FF9999", color="#e9ecef", alpha=0.9) +
  #scale_y_continuous(labels=scales::percent) +
  labs(y= "Frequency", x = "Test score")


# SPLIT PLOT

# 2023 VS PRE 2023
ggplot(data, aes(x=Total,fill=factor(G2023))) + 
  geom_histogram(binwidth=1, alpha=0.5, position = 'identity') +
  labs(y= "Frequency", x = "Test score") +
  scale_fill_discrete(labels = c(TRUE, FALSE))

# Electives 2023 VS PRE 2023
ggplot(data_no_electives, aes(x=Total,fill=factor(G2023))) + 
  geom_histogram(binwidth=1, alpha=0.5, position = 'identity') +
  labs(y= "Frequency", x = "Test score") +
  scale_fill_discrete(labels = c(TRUE, FALSE))


#### STASTISTICAL TESTING
# Difference 2023 and pre
stu_data = table(data_2023$Total, data_pre$Tota) 
chisq.test(stu_data)

m <-rbind(data_2023$Total, data_pre$Total)
chisq.test(m)

chisq.test(data_2023$Total, data_pre$Total, correct=FALSE)
chisq.test(data_2023$Total,p=data_pre$Total, simulate.p.value = T,rescale.p = T, B = 2000)
