#!/usr/bin/python
# Codefoces task parser

import re
import requests
import sys
import os
import shutil

def parse_problem(number, index):
    req = requests.get("http://codeforces.com/contest/" + number + "/problem/" + index)
    text = req.text

    input_data = re.findall("Input</div><pre>.*?</pre>", text)
    output_data = re.findall("Output</div><pre>.*?</pre>", text)

    for i in xrange(len(input_data)):
        input_data[i] = input_data[i][16:-12].replace("<br />", "\n")
        output_data[i] = output_data[i][17:-12].replace("<br />", "\n")
        # print input_data[i], output_data[i]

    os.mkdir("tests/" + index)

    num_tests = len(input_data)

    for i in xrange(num_tests):
        with open("tests/" + index + "/case" + str(i + 1) + ".in", "w") as f:
            print >> f, input_data[i]
        with open("tests/" + index + "/case" + str(i + 1) + ".out", "w") as f:
            print >> f, output_data[i]

    for i in xrange(num_tests, num_tests + 2):
        open("tests/" + index + "/case" + str(i + 1) + ".in", "w").close()
        open("tests/" + index + "/case" + str(i + 1) + ".out", "w").close()

def main():
    if len(sys.argv) < 2:
        print "Need contest number"
        sys.exit(0)

    number = sys.argv[1]

    req = requests.get("http://codeforces.com/contest/" + number)
    text = req.text
    problems = re.findall("/contest/" + number + "/problem/.", text)
    problems = sorted(set(problems))

    if os.path.exists("tests"):
        shutil.rmtree("tests")
    os.mkdir("tests")

    for problem in problems:
        print problem
        parse_problem(number, problem[-1])

if __name__ == '__main__':
    main()
