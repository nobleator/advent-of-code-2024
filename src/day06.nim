import std/strutils, std/sequtils, std/sets, std/tables, std/algorithm
import grid

proc d06a(input: string): int =
    var file = readFile(input)
    var rowCount = file.countLines()
    var colCount = len(file.split('\n', maxsplit=1)[0])
    var g: seq[seq[char]] = newSeq[seq[char]](rowCount)
    var start: (int, int)
    var r = 0
    var row = newSeq[char](colCount)
    for line in file.splitLines():
        for c, ch in line:
            row[c] = ch
            if ch == '^':
                start = (r, c)
        g[r] = row
        r += 1
    var visited = initHashSet[(int, int)]()
    visited.incl(start)
    var pos = start
    var dir = (-1, 0)
    const dirs = [(-1, 0), (0, 1), (1, 0), (0, -1)]
    while true:
        var npos = pos + dir
        if gridContains(g, npos):
            if get(g, npos) == '#':
                dir = dirs[(dirs.find(dir) + 1) mod dirs.len]
                npos = pos + dir
            pos = npos
            visited.incl(pos)
        else:
            break
    len(visited)

func sim(grid: Grid, start: (int, int)): (bool, HashSet[(int, int)]) =
    var g = grid
    const dirs = [(-1, 0), (0, 1), (1, 0), (0, -1)]
    # check for cycle with position + direction
    var cycleCheck = initHashSet[((int, int), (int, int))]()
    var visited = initHashSet[(int, int)]()
    visited.incl(start)
    var pos = start
    var dir = (-1, 0)
    var isCycle = false
    while true:
        var npos = pos + dir
        if gridContains(g, npos):
            while get(g, npos) == '#':
                dir = dirs[(dirs.find(dir) + 1) mod dirs.len]
                npos = pos + dir
            # if we see the same position + direction twice then we are guaranteed to cycle infinitely as the grid does not change dynamically
            if (npos, dir) in cycleCheck:
                isCycle = true
                break
            pos = npos
            visited.incl(pos)
            cycleCheck.incl((pos, dir))
        else:
            break
    (isCycle, visited)

proc d06b(input: string): int =
    var file = readFile(input)
    var rowCount = file.countLines()
    var colCount = len(file.split('\n', maxsplit=1)[0])
    var g: seq[seq[char]] = newSeq[seq[char]](rowCount)
    var start: (int, int)
    var r = 0
    var row = newSeq[char](colCount)
    for line in file.splitLines():
        for c, ch in line:
            row[c] = ch
            if ch == '^':
                start = (r, c)
        g[r] = row
        r += 1
    var (isCycle, visited) = sim(g, start)
    var cycleCausers = initHashSet[(int, int)]()
    visited.excl(start)
    for v in visited:
        var gCopy = g
        gCopy[v[0]][v[1]] = '#'
        var (isCycle, visited) = sim(gCopy, start)
        if isCycle:
            cycleCausers.incl(v)
    len(cycleCausers)

assert d06a("./test/day06.txt") == 41
echo "Part 1: ", d06a("./inputs/day06.txt")

assert d06b("./test/day06.txt") == 6
echo "Part 2: ", d06b("./inputs/day06.txt")
