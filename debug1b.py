import re
import subprocess

## The cobol program for DAY1B contained some kind of error but i could not find
## what. This program checks for each line that it has the correct output.
## The error turned out to be that the parser for "six" advanced the pointer
## by 3, which I forgot to remove at some point.

with open('DAY1.DAT', 'r') as f:
    contents = f.read()

def str_to_num(x):
    return {
        'one': 1,
        '1': 1,
        'two': 2,
        '2': 2,
        'three': 3,
        '3': 3,
        'four': 4,
        '4': 4,
        'five': 5,
        '5': 5,
        'six':  6,
        '6': 6,
        'seven': 7,
        '7': 7,
        'eight': 8,
        '8': 8,
        'nine': 9,
        '9': 9,
    }[x]

total = 0

for line in contents.split('\n'):
    if len(line) == 0:
        continue
    matches = re.findall('(?=(\d|one|two|three|four|five|six|seven|eight|nine))', line)
    num = 10 * str_to_num(matches[0]) + str_to_num(matches[-1])

    with open('DAY1.DAT', 'w') as f:
        f.write(line)
        f.write('\n')
    ret = subprocess.check_output(['./DAY1B'])
    retnum = int(ret)
    if retnum != num:
        print('Expected {} but got {}'.format(num, retnum))
        print(line)
        break

with open('DAY1.DAT', 'w') as f:
    f.write(contents)
