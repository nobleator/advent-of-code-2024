import std/strutils, std/sequtils, std/sets, std/tables

func getRules(input: string): Table[int, HashSet[int]] =
    var rules = initTable[int, HashSet[int]]()
    for line in input.splitLines():
        var test = line.split('|').map(parseInt)
        var lhs = test[0]
        var rhs = test[1]
        if rhs in rules:
            rules[rhs].incl(lhs)
        else:
            var s = initHashSet[int]()
            s.incl(lhs)
            rules[rhs] = s
    rules

func isValid(rules: Table[int, HashSet[int]], pages: seq[int]): bool =
    var fail = false
    for idx, p in pages:
        if p in rules:
            var rule = rules[p]
            var x = toHashSet(pages[idx..^1])
            if len(intersection(rule, x)) > 0:
                return false
    return true

proc d05a(input: string): int =
    var file = readFile(input)
    var segments = file.split("\n\n")
    var rules = getRules(segments[0])
    var correct: seq[seq[int]]
    for line in segments[1].splitLines():
        var pages = line.split(',').map(parseInt)
        if isValid(rules, pages):
            correct.add(pages)
    return correct.map(proc(x: seq[int]): int = x[len(x) div 2]).foldl(a + b)

proc d05b(input: string): int =
    return -1

assert d05a("./test/day05.txt") == 143
echo "Part 1: ", d05a("./inputs/day05.txt")

# assert d05b("./test/day05d.txt") == 9
# echo "Part 2: ", d05b("./inputs/day05.txt")