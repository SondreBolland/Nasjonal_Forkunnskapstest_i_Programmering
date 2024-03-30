import pandas as pd
import math
import replace_dicts

### Clean data ###
def replace_substrings(old_new_dict, filename):
    with open(filename, "r", encoding="utf8") as f:
        file_content = f.read()
        

    new_file_content = ""
    for key, value in old_new_dict.items():
        
        new_file_content = file_content.replace(key, value)
        file_content = new_file_content

    new_filename = path + "clean.csv"
    with open(new_filename, 'w', encoding="utf8") as f:
        f.write(new_file_content)
    f.close()
    return new_filename


# Original file
path = "data/"
filename = path + "total.csv"

# Replace escape characters from Nettskjema export
filename = replace_substrings(replace_dicts.escape_character_dict, filename)
print("Replace escape characters:", str(replace_dicts.escape_character_dict.items()))

# Replace all different variations of universities and høyskoler
filename = replace_substrings(replace_dicts.institution_dict, filename)
print("Replace all ambigious institutions with standardized labels:", str(replace_dicts.all_institutions))

# Replace all varations of gender with mann/kvinne
filename = replace_substrings(replace_dicts.gender_dict, filename)
print("Replace all ambigious genders with standardized labels: [\'m\', \'f\'] (other gender identities are not included)")

df = pd.read_csv(filename, on_bad_lines="skip", delimiter=";", encoding="utf8")

### Rename columns ###
column_names = {
    "Hva er ditt kjønn?": "Gender",
    "Hvilke studielinje/studieprogram går du?": "Studyprogram",
    "Hvilket universitet eller høyskole går du på?": "Institution",
    "Når fullførte du videregående skole?": "GraduateYear",
    "Lærte du å programmere i Python i matematikkfagene?": "LearnedPython",
    "Har du deltatt eller fullført et programmeringskurs ved universitet eller høyskole før denne testen?": "UniversityExperience",
    "Har du fullført noen av disse programfagene?_1": "IT1",
    "Har du fullført noen av disse programfagene?_2": "IT2",
    "Har du fullført noen av disse programfagene?_3": "PMX",
    "Hvilke matematikkfag fullførte du på videregående skole?_1": "P1",
    "Hvilke matematikkfag fullførte du på videregående skole?_2": "T1",
    "Hvilke matematikkfag fullførte du på videregående skole?_3": "P2",
    "Hvilke matematikkfag fullførte du på videregående skole?_4": "S1",
    "Hvilke matematikkfag fullførte du på videregående skole?_5": "S2",
    "Hvilke matematikkfag fullførte du på videregående skole?_6": "R1",
    "Hvilke matematikkfag fullførte du på videregående skole?_7": "R2", 
    "Å  gjøre en innsats i programmering er viktig, fordi det vil hjelpe meg i det arbeidet jeg skal gjøre senere.": "Effort",
    "Jeg arbeider med programmering fordi jeg liker det.": "Enjoyment",
    "Å  lære programmering er viktig for meg, fordi det vil bedre mine yrkesmuligheter.": "Work",
    "Jeg er interessert i det jeg lærer av programmering.": "Interest",
    "Programmering er viktig for meg, fordi jeg trenger det når jeg skal studere videre.": "Studies",
    "Har du annen erfaring med programmering utenfor skole?": "OutsideExperience",
    "Hvilken annen erfaring med programmering har du utenfor skole?_1": "Outside1",
    "Hvilken annen erfaring med programmering har du utenfor skole?_2": "Outside2",
    "Hvilken annen erfaring med programmering har du utenfor skole?_3": "Outside3",
    "Hvilken annen erfaring med programmering har du utenfor skole?_4": "Outside4",
    "Hvilken annen erfaring med programmering har du utenfor skole?_5": "Outside5",
    "Hvilken annen erfaring med programmering har du utenfor skole?_6": "Outside6",
    "Hvilken annen erfaring med programmering har du utenfor skole?_7": "Outside7",
    "Hvilken annen erfaring med programmering har du utenfor skole?_8": "Outside8"
}

df.rename(columns=column_names, inplace=True)
print("Rename columns with simpler titles. Easier to use in analysis.")

# Remove all institutions that are not in the list
df.loc[(~df['Institution'].isin(replace_dicts.all_institutions)), 'Institution'] = " "
print("Removed all institutions that are not in:", str(replace_dicts.all_institutions))

# Remove all genders that are not male or female. The other gender identities do not have a large enough sample size for valid statistical analysis
df.loc[(~df['Gender'].isin(['f', 'm'])), 'Gender'] = " "
print("Removed all genders that are not in: [\'m\', \'f\']. The other gender identities do not have a large enough sample size for valid statistical analysis.")

# Remove false entries
df = df.drop(index=[0, 1, 2, 3, 4, 5])
print("Removed false entries")


# REMOVE ALL BLANK ANSWERS
programming_question_index = 43

# Drop all non programming question columns
drop_columns = list(range(0, programming_question_index))
prog_df = df.drop(df.columns[drop_columns], axis=1)

# Remove all blank answers
count_removed = 0
for i in range(6, len(prog_df.index)):
    blank_answer = True
    for column in prog_df:
        if column == "Sum" or column == "Svartid":
            continue
        student_answer = prog_df[column][i]
        if type(student_answer) == str:
            blank_answer = False
            break
        if not math.isnan(student_answer):
            blank_answer = False
            break
    if blank_answer:
        count_removed += 1
        df = df.drop(index=[i])
print("Removed blank submissions:", count_removed)

df.to_csv(filename, encoding="utf8", sep=";")

