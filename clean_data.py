import pandas as pd
import math
import data_replacements

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
filename = replace_substrings(data_replacements.escape_character_dict, filename)
print("Replace escape characters:", str(data_replacements.escape_character_dict.items()))

# Replace all different variations of universities and høyskoler
filename = replace_substrings(data_replacements.institution_dict, filename)
print("Replace all ambigious institutions with standardized labels:", str(data_replacements.all_institutions))

# Replace all varations of gender with mann/kvinne
filename = replace_substrings(data_replacements.gender_dict, filename)
print("Replace all ambigious genders with standardized labels: [\'m\', \'f\'] (other gender identities are not included)")

df = pd.read_csv(filename, on_bad_lines="skip", delimiter=";", encoding="utf8")

### Rename columns ###
df.rename(columns=data_replacements.new_column_names, inplace=True)
print("Rename columns with simpler titles. Easier to use in analysis.")

# Remove all institutions that are not in the list
df.loc[(~df['Institution'].isin(data_replacements.all_institutions)), 'Institution'] = " "
print("Removed all institutions that are not in:", str(data_replacements.all_institutions))

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

