import std/strutils, std/sequtils, std/math, std/tables

func brute(stones: seq[string]): seq[string] =
    var next: seq[string] = @[]
    for s in stones:
        if s == "0":
            next.add("1")
        elif len(s) mod 2 == 0:
            let m = (len(s) div 2)-1
            let lhs = s[0..m]
            let rhs = s[m+1..^1]
            next.add($(parseInt(lhs)))
            next.add($(parseInt(rhs)))
        else:
            next.add($(parseInt(s)*2024))
    next

# (rockNumber, blinksRemaining): countOfRocks
var cache = initTable[(int, int), int64]()
proc memoRec(stone, blinks: int): int =
    if blinks == 0:
        return 1
    if (stone, blinks) in cache:
        return cache[(stone, blinks)]
    if stone == 0:
        var s = memoRec(1, blinks-1)
        cache[(1, blinks-1)] = s
        return s
    elif len($stone) mod 2 == 0:
        let m = (len($stone) div 2)-1
        let lhs = parseInt(($stone)[0..m])
        let rhs = parseInt(($stone)[m+1..^1])
        var s1 = memoRec(lhs, blinks-1)
        var s2 = memoRec(rhs, blinks-1)
        cache[(lhs, blinks-1)] = s1
        cache[(rhs, blinks-1)] = s2
        return s1 + s2
    else:
        var s = memoRec(stone*2024, blinks-1)
        cache[(stone*2024, blinks-1)] = s
        return s

proc d11a(input: string): int =
    var stones = readFile(input).split(' ')
    var ctr = 0
    while ctr < 25:
        stones = brute(stones)
        ctr += 1
    len(stones)

proc d11b(input: string): int =
    readFile(input).split(' ').map(parseInt).map(proc(x: int): int = memoRec(x, 75)).foldl(a+b)

assert d11a("./test/day11.txt") == 55312
echo "Part 1: ", d11a("./inputs/day11.txt")

echo "Part 2: ", d11b("./inputs/day11.txt")