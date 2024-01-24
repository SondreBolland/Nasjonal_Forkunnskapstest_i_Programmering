import pandas as pd
import json
import math

### Load data as dataframe ###
# NB: Run clean_data.py first
path = "data/"
filename = path + "clean.csv"
df = pd.read_csv(filename, on_bad_lines="skip", delimiter=";", encoding="utf8")

#### Compare with rubric ####
# Index of which question and onwards are programming questions to be graded
programming_question_index = 43

# Drop all non programming question columns
drop_columns = list(range(0, programming_question_index))
prog_df = df.drop(df.columns[drop_columns], axis=1)

# Remove all blank answers
count_removed = 0
for i in range(len(prog_df.index)):
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

print("Removed:", count_removed)

# Get rubric
rubric = json.load(open("rubric.json", encoding="utf8"))

# Maximum score
max_score = 0
for key in rubric.keys():
    topic = rubric[key]
    for question in topic["answers"]:
        max_score += topic["score"]

print("Max score:", max_score)

# Create dataframe for results
result_df = df.copy()
result_df["Total"] = None

# Add topic columns
for topic in rubric.keys():
    result_df[str(topic)] = None

for i in range(len(prog_df.index)):
    sum = 0
    for key in rubric.keys():
        topic = rubric[key]
        topic_sum = 0
        task_points = topic["score"]
        for question in topic["answers"]:
            try:
                correct_answer = topic["answers"][question]
                student_answer = prog_df[question][i]
                # Cast the answer in the correct datatype
                student_answer = type(correct_answer)(student_answer)

                if correct_answer == student_answer:
                    points = task_points
                    topic_sum += points
                    sum += task_points
                else:
                    points = 0

                result_df[question][i] = points
            except KeyError:
                continue
            except ValueError:
                # Cast error. Set score as zero
                result_df[question][i] = 0
                continue
        result_df[str(key)][i] = topic_sum
        
    result_df["Total"][i] = sum

result_df.to_csv(path + 'results.csv', sep=";")