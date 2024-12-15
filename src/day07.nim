import std/strutils, std/sequtils
import algo

const ops = @['+', '*']
const ops2 = @['+', '*', '|']

proc d07a(input: string): int =
    var text = readFile(input)
    var overall = 0
    for line in text.splitLines():
        var segments = line.split(": ")
        var lhs = parseInt(segments[0])
        var rhs = segments[1].split().map(parseInt)
        for p in getPermutations(ops, len(rhs)-1):
            var total = rhs[0]
            for i in 0..len(rhs)-2:
                var nv = rhs[i+1]
                if p[i] == '+':
                    total += nv
                elif p[i] == '*':
                    total *= nv
                # As there are no negative or decimal numbers, addition and multiplication will only ever increase the total. Therefore, if we have already exceeded the total there is no need for further computation.
                if total > lhs:
                    break
            if total == lhs:
                overall += lhs
                break
    overall

proc d07b(input: string): int =
    var text = readFile(input)
    var overall = 0
    for line in text.splitLines():
        var segments = line.split(": ")
        var lhs = parseInt(segments[0])
        var rhs = segments[1].split().map(parseInt)
        for p in getPermutations(ops2, len(rhs)-1):
            var total = rhs[0]
            for i in 0..len(rhs)-2:
                var nv = rhs[i+1]
                if p[i] == '+':
                    total += nv
                elif p[i] == '*':
                    total *= nv
                elif p[i] == '|':
                    total = parseInt($total & $nv)
                if total > lhs:
                    break
            if total == lhs:
                overall += lhs
                break
    overall

assert d07a("./test/day07.txt") == 3749
echo "Part 1: ", d07a("./inputs/day07.txt")

assert d07b("./test/day07.txt") == 11387
echo "Part 2: ", d07b("./inputs/day07.txt")
