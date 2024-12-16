import std/strutils, std/sequtils, std/sets, std/tables, std/math
import grid, algo

func getAntinodes(p1, p2: (int, int)): seq[(int, int)] =
    let v = p1-p2
    var a = toHashSet([p1+v, p1-v, p2+v, p2-v])
    var b = toHashSet([p1, p2])
    a.excl(b)
    toSeq(a)

func getResonantAntinodes(g: Grid, p1, p2: (int, int)): seq[(int, int)] =
    let v = p1-p2
    var res: seq[(int, int)] = @[p1, p2]
    var x = p1+v
    while gridContains(g, x):
        res.add(x)
        x = x+v
    x = p1-v
    while gridContains(g, x):
        res.add(x)
        x = x-v
    x = p2+v
    while gridContains(g, x):
        res.add(x)
        x = x+v
    x = p2-v
    while gridContains(g, x):
        res.add(x)
        x = x-v
    res

proc d08a(input: string): int =
    var file = readFile(input)
    var rowCount = file.countLines()
    var colCount = len(file.split('\n', maxsplit=1)[0])
    var g: seq[seq[char]] = newSeq[seq[char]](rowCount)
    var antennas = initTable[char, HashSet[(int, int)]]()
    var r = 0
    var row = newSeq[char](colCount)
    for line in file.splitLines():
        for c, ch in line:
            row[c] = ch
            if ch != '.':
                if ch in antennas:
                    antennas[ch].incl((r, c))
                else:
                    var s = initHashSet[(int, int)]()
                    s.incl((r, c))
                    antennas[ch] = s
        g[r] = row
        r += 1
    var antinodes = initHashSet[(int, int)]()
    for k, v in antennas.pairs:
        for p in pairwise(toSeq(v)):
            let an = getAntinodes(p[0], p[1])
            for a in an:
                if gridContains(g, a):
                    antinodes.incl(a)
    len(antinodes)

proc d08b(input: string): int =
    var file = readFile(input)
    var rowCount = file.countLines()
    var colCount = len(file.split('\n', maxsplit=1)[0])
    var g: seq[seq[char]] = newSeq[seq[char]](rowCount)
    var antennas = initTable[char, HashSet[(int, int)]]()
    var r = 0
    var row = newSeq[char](colCount)
    for line in file.splitLines():
        for c, ch in line:
            row[c] = ch
            if ch != '.':
                if ch in antennas:
                    antennas[ch].incl((r, c))
                else:
                    var s = initHashSet[(int, int)]()
                    s.incl((r, c))
                    antennas[ch] = s
        g[r] = row
        r += 1
    var antinodes = initHashSet[(int, int)]()
    for k, v in antennas.pairs:
        for p in pairwise(toSeq(v)):
            let an = getResonantAntinodes(g, p[0], p[1])
            for a in an:
                antinodes.incl(a)
    len(antinodes)

assert d08a("./test/day08.txt") == 14
echo "Part 1: ", d08a("./inputs/day08.txt")

assert d08b("./test/day08.txt") == 34
assert d08b("./test/day08b.txt") == 9
echo "Part 2: ", d08b("./inputs/day08.txt")
