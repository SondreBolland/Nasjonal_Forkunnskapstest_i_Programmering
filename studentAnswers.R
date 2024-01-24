setwd("C:/Users/sondr/Documents/Locker/Skole/Didaktikk - PhD/research projects/kartlegging/analysis") # you'll set this to your directory
source("load_data.R")
source("functions.R")
setwd("C:/Users/sondr/Documents/Locker/Skole/Didaktikk - PhD/research projects/kartlegging/analysis/data") # you'll set this to your directory


data_ans = read.csv("clean.csv", sep = ';', fileEncoding="UTF-8-BOM")
nrow(data_ans)

# Has taken a programming course at university
table(data$UniversityExperience, useNA = "always")

data_ans$UniversityExperience[data_ans$UniversityExperience == "Ja, kurset ga 10 studiepoeng"] = TRUE
data_ans$UniversityExperience[data_ans$UniversityExperience == "Ja, kurset ga 5 studiepoeng"] = TRUE
data_ans$UniversityExperience[data_ans$UniversityExperience == "Ja, kurset ga 7.5 studiepoeng"] = TRUE
data_ans$UniversityExperience[data_ans$UniversityExperience == "Ja, men kurset ga ikke studiepoeng"] = TRUE
data_ans$UniversityExperience[data_ans$UniversityExperience == "Nei"] = FALSE

# Filter out those you have taken a programming course at university
data_ans = data_ans %>%
  filter(UniversityExperience %in% c(FALSE))

colnames(data_ans)

### LISTS ###

data_ans$Lists1 = data_ans$Hva.skrives.ut.når.dette.programmet.kjøres..5
data_ans$Lists2 = data_ans$Hva.skrives.ut.når.dette.programmet.kjøres..6
data_ans$Lists3 = data_ans$Hva.skrives.ut.når.dette.programmet.kjøres..7

data_pre2023 = data_ans %>%
  filter(GraduateYear %in% c("Før 2020", "2020", "2021 - 2022"))

data_ans = data_ans %>%
  filter(GraduateYear %in% c("2023"))


count(data_ans$Lists1)
length(data_ans$Lists1)

count(data_ans$Lists2)
length(data_ans$Lists2)

count(data_ans$Lists3)
length(data_ans$Lists3)




### DATATYPES ###
count(data_ans$a)
length(data_ans$a)

count(data_ans$b)
length(data_ans$b)

count(data_ans$c)
length(data_ans$c)

count(data_ans$d)
length(data_ans$d)

count(data_ans$a...d)
length(data_ans$a...d)

count(data_ans$c....10.3)
length(data_ans$c....10.3)

count(data_ans$a...a)
length(data_ans$a...a)

count(data_ans$X.a.)
length(data_ans$X.a.)

count(data_ans$b...c)
length(data_ans$b...c)

count(data_ans$a...b)
length(data_ans$a...b)

count(data_ans$a...b..)
length(data_ans$a...b..)

### LOOPS

data_ans$Loops1 = data_ans$Hva.skrives.ut.når.dette.programmet.kjøres..3
data_ans$Loops2 = data_ans$Hva.skrives.ut.når.dette.programmet.kjøres..4

count(data_ans$Loops1)
length(data_ans$Loops1)

count(data_ans$Loops2)
length(data_ans$Loops2)

### FUNCTIONS

data_ans$Function1= data_ans$Hva.skrives.ut.når.dette.programmet.kjøres..8
data_ans$Function2 = data_ans$Hva.skrives.ut.når.dette.programmet.kjøres..9
data_ans$Function3 = data_ans$Funksjonen.over.skal.finne.det.minste.elementet.i.en.liste..Hva.må.skrives.på.linje.5.for.at.funksjonen.skal.være.riktig.
data_ans$Function4 = data_ans$Hva.skrives.ut.når.dette.programmet.kjøres..10
data_ans$Function5 = data_ans$Hva.skrives.ut.når.dette.programmet.kjøres..11
data_ans$Function6 = data_ans$Hva.skrives.ut.når.dette.programmet.kjøres..12


count(data_ans$Function1)
length(data_ans$Function1)

count(data_ans$Function2)
length(data_ans$Function2)

count(data_ans$Function3)
length(data_ans$Function3)

count(data_ans$Function4)
length(data_ans$Function4)

count(data_ans$Function5)
length(data_ans$Function5)

count(data_ans$Function6)
length(data_ans$Function6)


### Bool

data_ans$Bool1 = data_ans$X100....100
data_ans$Bool2 = data_ans$X42....25                                                                                                                      
data_ans$Bool3 = data_ans$not..100....100.                                                                                                               
data_ans$Bool4 = data_ans$X.10.2....9
data_ans$Bool5 = data_ans$X100....100.1
data_ans$Bool6 = data_ans$X99....100
data_ans$Bool7 = data_ans$X100.....50.2.
data_ans$Bool8 = data_ans$X.14.2....7
data_ans$Bool9 = data_ans$X.5...7..and..4...5.
data_ans$Bool10 = data_ans$X.3...7..and..7...9.
data_ans$Bool11 = data_ans$X.5...7..or..4...5.
data_ans$Bool12 = data_ans$and.500....100
data_ans$Bool13 = data_ans$X.False....False......True....True.
data_ans$Bool14 = data_ans$X.not.True..or.False
data_ans$Bool15 = data_ans$False..not.False.
data_ans$Bool16 = data_ans$True.and.False
data_ans$Bool17 = data_ans$True.and..False.or.True.

count(data_ans$Bool1)
length(data_ans$Bool1)

count(data_ans$Bool2)
length(data_ans$Bool2)

count(data_ans$Bool3)
length(data_ans$Bool3)

count(data_ans$Bool4)
length(data_ans$Bool4)

count(data_ans$Bool5)
length(data_ans$Bool5)

count(data_ans$Bool6)
length(data_ans$Bool6)

count(data_ans$Bool7)
length(data_ans$Bool7)

count(data_ans$Bool8)
length(data_ans$Bool8)

count(data_ans$Bool9)
length(data_ans$Bool9)

count(data_ans$Bool10)
length(data_ans$Bool10)

count(data_ans$Bool11)
length(data_ans$Bool11)

count(data_ans$Bool12)
length(data_ans$Bool12)

count(data_ans$Bool13)
length(data_ans$Bool13)

count(data_ans$Bool14)
length(data_ans$Bool14)

count(data_ans$Bool15)
length(data_ans$Bool15)

count(data_ans$Bool16)
length(data_ans$Bool16)

count(data_ans$Bool17)
length(data_ans$Bool17)



# Conditionals
data_ans$Conditional1 = data_ans$Hva.skrives.ut.når.programmet.kjøres.
data_ans$Conditional2 = data_ans$Hva.må.vi.sette.inn.i.koden..rød.strek..for.at.15.skal.skrives.ut.                                                                                                                      
data_ans$Conditional3 = data_ans$Hva.skrives.ut.når.dette.programmet.kjøres..2  


count(data_ans$Conditional1)
length(data_ans$Conditional1)

count(data_ans$Conditional2)
length(data_ans$Conditional2)

count(data_ans$Conditional3)
length(data_ans$Conditional3)

# Conditionals
data_ans$Variables1 = data_ans$Hva.skrives.ut.når.dette.programmet.kjøres.
data_ans$Variables2 = data_ans$Hva.skrives.ut.når.dette.programmet.kjøres..1                                                                                                                      


count(data_ans$Variables1)
length(data_ans$Variables1)

count(data_ans$Variables2)
length(data_ans$Variables2)
