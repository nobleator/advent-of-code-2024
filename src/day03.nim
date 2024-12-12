import std/re, std/strutils, std/sequtils

proc d03a(input: string): int =
    let pattern = re"mul\(\d{1,3},\d{1,3}\)"
    let matches = re.findAll(readFile(input), pattern)
    var sum = 0
    for match in matches:
        let digitsPattern = re"\d{1,3}"
        sum += re.findAll(match, digitsPattern).map(parseInt).foldl(a * b)
    return sum

proc d03b(input: string): int =
    let pattern = re"mul\(\d{1,3},\d{1,3}\)|do\(\)|don't\(\)"
    let digitsPattern = re"\d{1,3}"
    var text = readFile(input)
    let matches = re.findAll(text, pattern)
    var active = true
    var sum = 0
    for match in matches:
        if "don't" in match:
            active = false
        elif "do" in match:
            active = true
        if active and "mul" in match:
            sum += re.findAll(match, digitsPattern).map(parseInt).foldl(a * b)
    return sum

assert d03a("./test/day03.txt") == 161
echo "Part 1: ", d03a("./inputs/day03.txt")

assert d03b("./test/day03b.txt") == 48
echo "Part 2: ", d03b("./inputs/day03.txt")