import re

pattern = re.compile("[Kk]vinne|^[Ff]$|[Hh]o|[Hh]u|[Jj]ente")
test_text = "Hei Kvinne ad ho hunkjønn "
matching = pattern.search(test_text)
if matching:
    print("kka")
print(matching)