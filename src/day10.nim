import std/strutils, std/sets, std/math
import grid

func climableNeighbors(grid: Grid, point: (int, int)): seq[(int, int)] =
    let h = parseInt($get(grid, point))
    let neighbors = getOrthogonal(grid, point)
    var res: seq[(int, int)]
    for n in neighbors:
        let c = get(grid, n)
        if isDigit(c):
            let v = parseInt($c)
            if v-h == 1:
                res.add(n)
    res

func walk(grid: Grid, point: (int, int)): int =
    let h = parseInt($get(grid, point))
    if h == 9:
        return 1
    let neighbors = getOrthogonal(grid, point)
    var res: seq[(int, int)]
    var score = 0
    for n in neighbors:
        let c = get(grid, n)
        if isDigit(c):
            let v = parseInt($c)
            if v-h == 1:
                score += walk(grid, n)
    return score

proc d10a(input: string): int =
    var file = readFile(input)
    var rowCount = file.countLines()
    var colCount = len(file.split('\n', maxsplit=1)[0])
    var g: seq[seq[char]] = newSeq[seq[char]](rowCount)
    var r = 0
    var row = newSeq[char](colCount)
    var trailheads: seq[(int, int)]
    for line in file.splitLines():
        for c, ch in line:
            row[c] = ch
            if ch == '0':
                trailheads.add((r, c))
        g[r] = row
        r += 1
    var score = 0
    for t in trailheads:
        var toVisit: seq[(int, int)]
        var visited = initHashSet[(int, int)]()
        visited.incl(t)
        for n in climableNeighbors(g, t):
            toVisit.add(n)
        while len(toVisit) > 0:
            var x = toVisit[0]
            toVisit = toVisit[1..^1]
            if visited.contains(x):
                continue
            if parseInt($get(g, x)) == 9:
                score += 1
            visited.incl(x)
            for n in climableNeighbors(g, x):
                toVisit.add(n)
    score

proc d10b(input: string): int =
    var file = readFile(input)
    var rowCount = file.countLines()
    var colCount = len(file.split('\n', maxsplit=1)[0])
    var g: seq[seq[char]] = newSeq[seq[char]](rowCount)
    var r = 0
    var row = newSeq[char](colCount)
    var trailheads: seq[(int, int)]
    for line in file.splitLines():
        for c, ch in line:
            row[c] = ch
            if ch == '0':
                trailheads.add((r, c))
        g[r] = row
        r += 1
    var score = 0
    for t in trailheads:
        score += walk(g, t)
    score

assert d10a("./test/day10a.txt") == 1
assert d10a("./test/day10b.txt") == 2
assert d10a("./test/day10c.txt") == 4
assert d10a("./test/day10d.txt") == 3
assert d10a("./test/day10e.txt") == 36
echo "Part 1: ", d10a("./inputs/day10.txt")

assert d10b("./test/day10e.txt") == 81
assert d10b("./test/day10f.txt") == 3
assert d10b("./test/day10g.txt") == 13
assert d10b("./test/day10h.txt") == 227
echo "Part 2: ", d10b("./inputs/day10.txt")
