import std/re, std/strutils, std/sequtils

type
  Row = seq[char]
  Grid = seq[Row]

proc d04a(input: string): int =
    var file = readFile(input)
    var rowCount = file.countLines()
    var colCount = len(file.split('\n', maxsplit=1)[0])
    var g: seq[seq[char]] = newSeq[seq[char]](rowCount)
    var r = 0
    var row = newSeq[char](colCount)
    for line in file.splitLines():
        for c, ch in line:
            row[c] = ch
        g[r] = row
        r += 1
    var ctr = 0
    for r, row in g:
        for c, val in row:
            if val == 'X':
                # right
                if c < colCount-3 and g[r][c] & g[r][c+1] & g[r][c+2] & g[r][c+3] == "XMAS":
                    ctr += 1           
                # left
                if c >= 3 and g[r][c] & g[r][c-1] & g[r][c-2] & g[r][c-3] == "XMAS":
                    ctr += 1
                # up left
                if c >= 3 and r >= 3 and g[r][c] & g[r-1][c-1] & g[r-2][c-2] & g[r-3][c-3] == "XMAS":
                    ctr += 1
                # up
                if r >= 3 and g[r][c] & g[r-1][c] & g[r-2][c] & g[r-3][c] == "XMAS":
                    ctr += 1
                # up right
                if c < colCount-3 and r >= 3 and g[r][c] & g[r-1][c+1] & g[r-2][c+2] & g[r-3][c+3] == "XMAS":
                    ctr += 1
                # down left
                if c >= 3 and r < rowCount-3 and g[r][c] & g[r+1][c-1] & g[r+2][c-2] & g[r+3][c-3] == "XMAS":
                    ctr += 1
                # down
                if r < rowCount-3 and g[r][c] & g[r+1][c] & g[r+2][c] & g[r+3][c] == "XMAS":
                    ctr += 1
                # down right
                if c < colCount-3 and r < rowCount-3 and g[r][c] & g[r+1][c+1] & g[r+2][c+2] & g[r+3][c+3] == "XMAS":
                    ctr += 1
    return ctr

proc d04b(input: string): int =
    return -1

assert d04a("./test/day04a.txt") == 4
assert d04a("./test/day04b.txt") == 8
assert d04a("./test/day04c.txt") == 18
echo "Part 1: ", d04a("./inputs/day04.txt")

# assert d04b("./test/day03b.txt") == 4
# echo "Part 2: ", d04b("./inputs/day04.txt")