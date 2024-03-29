setwd("C:/Users/sondr/Documents/Locker/Skole/Didaktikk - PhD/research projects/kartlegging/analysis") # you'll set this to your directory
source("load_data.R")

table(data$P1, useNA = "always")
table(data$P2, useNA = "always")
table(data$T1, useNA = "always")
table(data$S1, useNA = "always")
table(data$S2, useNA = "always")
table(data$R1, useNA = "always")
table(data$R2, useNA = "always")


table(data$SocialMath, useNA = "always")
table(data$ScienceMath, useNA = "always")
table(data$PracticalMath, useNA = "always")


#Other
data_other =  data %>%
  filter(SocialMath %in% c(FALSE), ScienceMath %in% c(FALSE), PracticalMath %in% c(FALSE))
score_analysis(data_other)

table(data_other$P1, useNA = "always")
table(data_other$P2, useNA = "always")
table(data_other$T1, useNA = "always")
table(data_other$S1, useNA = "always")
table(data_other$S2, useNA = "always")
table(data_other$R1, useNA = "always")
table(data_other$R2, useNA = "always")

# All
data_social =  data %>%
  filter(SocialMath %in% c(TRUE))
score_analysis(data_social)

data_base_social =  data %>%
  filter(BaseSocialMath %in% c(TRUE))
score_analysis(data_base_social)

data_science =  data %>%
  filter(ScienceMath %in% c(TRUE))
score_analysis(data_science)

data_base_science =  data %>%
  filter(BaseScienceMath %in% c(TRUE))
score_analysis(data_base_science)

data_practical = data %>%
  filter(PracticalMath %in% c(TRUE))
score_analysis(data_practical)

# Pre 2023
data_social =  data %>%
  filter(SocialMath %in% c(TRUE))
score_analysis(data_social, 1)

data_science =  data %>%
  filter(ScienceMath %in% c(TRUE))
score_analysis(data_science, 1)

data_base_science =  data %>%
  filter(BaseScienceMath %in% c(TRUE))
score_analysis(data_base_science, 1)

data_practical = data %>%
  filter(PracticalMath %in% c(TRUE))
score_analysis(data_practical, 1)

# 2023
data_social =  data %>%
  filter(SocialMath %in% c(TRUE))
score_analysis(data_social, 2)

data_science =  data %>%
  filter(ScienceMath %in% c(TRUE))
score_analysis(data_science, 2)

data_base_science =  data %>%
  filter(BaseScienceMath %in% c(TRUE))
score_analysis(data_base_science, 2)

data_practical = data %>%
  filter(PracticalMath %in% c(TRUE))
score_analysis(data_practical, 2)

data_violin = data
data_violin$Math = NA
data_violin$Math[data_violin$P2 == TRUE & data_violin$S2 == FALSE & data_violin$R1 == FALSE & data_violin$R2 == FALSE] = "P2"
data_violin$Math[data_violin$S2 == TRUE & data_violin$R1 == FALSE & data_violin$R2 == FALSE] = "R S2"
data_violin$Math[data_violin$R1 == TRUE & data_violin$R2 == FALSE] = "R1"
data_violin$Math[data_violin$R2 == TRUE] = "R2"

data_violin$Math[is.na(data_violin$Math)] = "Other courses"

table(data_violin$Math, useNA = "always")

data_violin = data_violin %>%
  filter(Math %in% c("P2"))
table(data_violin$Math, useNA = "always")
score_analysis(data_violin)




### Violin Plot
#Score plot
ggplot(data_violin, aes(x=Math, y=(Total/22.6), fill=Math)) + 
  labs(y= "Score", x = "Math course") +
  scale_y_continuous(labels=scales::percent) +
  
  # geom_violin() function is used to plow violin plot
  geom_violin()+
  
  # Stat_summary() function adds mean marker on plot
  stat_summary(fun.y="mean", geom="point", size=2, color="red") +
  theme(axis.title.x = element_blank()) 
