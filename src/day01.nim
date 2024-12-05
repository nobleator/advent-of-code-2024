import std/strutils, std/sequtils, std/algorithm, std/sets

proc d01a(input: string): int =
    var lhs: seq[int]
    var rhs: seq[int]
    let file = readFile(input)
    for line in file.split("\n"):
        let s = line.split("   ")
        lhs.add(parseInt(s[0]))
        rhs.add(parseInt(s[1]))
    lhs.sort()
    rhs.sort()
    var s = 0
    for (l, r) in zip(lhs, rhs):
        s += abs(l - r)
    s

proc d01b(input: string): int =
    var lhs: seq[int]
    var rhs: seq[int]
    let file = readFile(input)
    for line in file.split("\n"):
        let s = line.split("   ")
        lhs.add(parseInt(s[0]))
        rhs.add(parseInt(s[1]))
    var s = 0
    for n in lhs.toHashSet:
        var lc = count(lhs, n)
        var rc = count(rhs, n)
        s += n * lc * rc
    s

assert d01a("./test/day01.txt") == 11
echo "Part 1: ", d01a("./inputs/day01.txt")

assert d01b("./test/day01.txt") == 31
echo "Part 2: ", d01b("./inputs/day01.txt")
