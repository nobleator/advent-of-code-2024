import std/strutils, std/sequtils
const lb = 1
const ub = 3

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

func isSafe(r: seq[int]): bool =
    var isAsc, isDesc = true
    for idx, v in r:
        if idx > 0 and isAsc:
            let d = v - r[idx - 1]
            let inBounds = d >= lb and d <= ub
            if not inBounds:
                isAsc = false
    for idx, v in r:
        if idx > 0 and isDesc:
            let d = r[idx - 1] - v
            let inBounds = d >= lb and d <= ub
            if not inBounds:
                isDesc = false
    return isAsc or isDesc

proc d01b(input: string): int =
    let file = readFile(input)
    var safe = 0
    for line in file.split("\n"):
        let s = line.split(" ").map(parseInt)
        if isSafe(s):
            safe += 1
        else:
            for idx, v in s:
                var split = s[0..idx-1] & s[idx+1..len(s)-1]
                if isSafe(split):
                    safe += 1
                    break
    safe

assert d01a("./test/day02.txt") == 2
echo "Part 1: ", d01a("./inputs/day02.txt")

assert d01b("./test/day02.txt") == 4
echo "Part 2: ", d01b("./inputs/day02.txt")