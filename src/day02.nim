import std/strutils, std/sequtils, std/algorithm, std/sets, std/strformat

proc d01a(input: string): int =
    const lb = 1
    const ub = 3
    let file = readFile(input)
    var safe = 0
    for line in file.split("\n"):
        let s = line.split(" ").map(parseInt)
        var ctr, dir, pv = 0
        for idx, v in s:
            let diff = abs(pv - v)
            if idx > 0 and dir == 0:
                if pv < v:
                    dir = 1
                elif pv > v:
                    dir = -1
                elif pv == v:
                    dir = 0
            if (pv < v and dir == -1) or
               (pv > v and dir == 1) or
               (idx > 0 and (diff > ub or diff < lb)):
                break
            ctr += 1
            pv = v
        if len(s) == ctr:
            safe += 1
    safe

proc d01b(input: string): int =
    -1

assert d01a("./test/day02.txt") == 2
echo "Part 1: ", d01a("./inputs/day02.txt")

# assert d01b("./test/day02.txt") == -1
# echo "Part 2: ", d01b("./inputs/day02.txt")