import std/strutils, std/sequtils, std/sets, std/tables, std/algorithm

const ops = @['+', '*']

func generatePermutations(ops: seq[char], length: int, current: seq[char], result: var seq[seq[char]]) =
    if len(current) == length:
        result.add(current)
    else:
        for o in ops:
            var newSeq = current
            newSeq.add(o)
            generatePermutations(ops, length, newSeq, result)

func getPermutations(ops: seq[char], length: int): seq[seq[char]] =
    var result: seq[seq[char]] = @[]
    generatePermutations(ops, length, @[], result)
    return result

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
    -1

assert d07a("./test/day07.txt") == 3749
echo "Part 1: ", d07a("./inputs/day07.txt")

# assert d07b("./test/day07.txt") == 6
# echo "Part 2: ", d07b("./inputs/day07.txt")
