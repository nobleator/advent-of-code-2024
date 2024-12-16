import std/strutils, std/sequtils, std/sets, std/tables, std/math

proc d09a(input: string): int64 =
    var text = readFile(input)
    # Note to use a string here, not a character, as file IDs will be > 9
    var mem: seq[string]
    var fid = 0
    for i, c in text:
        for n in 0..parseInt($c)-1:
            if i mod 2 == 0:
                mem.add($fid)
            else:
                mem.add(".")
        if i mod 2 == 0:
            fid += 1
    var lhs = 0
    var rhs = len(mem)-1
    while lhs < rhs:
        if mem[rhs] == ".":
            rhs -= 1
        elif mem[lhs] != ".":
            lhs += 1
        else:
            mem[lhs] = mem[rhs]
            mem[rhs] = "."
            rhs -= 1
            lhs += 1
    var total = 0
    for i, v in mem:
        if v == ".":
            break
        total += i * parseInt($v)
    total

proc d09b(input: string): int =
    -1

assert d09a("./test/day09a.txt") == 1928
assert d09a("./test/day09b.txt") == 60
assert d09a("./test/day09c.txt") == 385
echo "Part 1: ", d09a("./inputs/day09.txt")

# assert d09b("./test/day09.txt") == 34
# echo "Part 2: ", d09b("./inputs/day09.txt")
