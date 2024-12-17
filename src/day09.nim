import std/strutils, std/sequtils, std/math, std/algorithm

type
    File = object
        start: int
        size: int
        id: int

func fileCmp(f1, f2: File): int =
    if f1.id > f2.id: return -1
    if f1.id < f2.id: return 1
    return 0

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

# debug helper
proc printMem(length: int, free: seq[(int, int)], files: seq[File]) =
    var s: seq[string] = @[]
    for i in 0..length:
        var x = files.filterIt(i >= it.start and i < it.start+it.size)
        if len(x) > 0:
            s.add($(x[0].id))
        else:
            s.add(".")
    echo s.join()

proc d09b(input: string): int =
    var text = readFile(input)
    var free: seq[(int, int)]
    var files: seq[File]
    var
        fid = 0
        pos = 0
    for i, c in text:
        var cv = parseInt($c)
        if i mod 2 == 0:
            files.add(File(start: pos, size: cv, id: fid))
            fid += 1
        else:
            free.add((pos, cv))
        pos += cv
    files.sort(fileCmp)
    for fidx in 0..len(files)-1:
        free.sort(proc(a, b: (int, int)): int = cmp(a[0], b[0]))
        for freeIdx in 0..len(free)-1:
            if free[freeIdx][0] < files[fidx].start and free[freeIdx][1] >= files[fidx].size:
                files[fidx].start = free[freeIdx][0]
                free[freeIdx][0] = files[fidx].start+files[fidx].size
                free[freeIdx][1] -= files[fidx].size
                break
    files.sort(proc(a, b: File): int = cmp(a.start, b.start))
    var total = 0
    for f in files:
        for idx in f.start..f.start+f.size-1:
            total += idx * f.id
    total

assert d09a("./test/day09a.txt") == 1928
assert d09a("./test/day09b.txt") == 60
assert d09a("./test/day09c.txt") == 385
echo "Part 1: ", d09a("./inputs/day09.txt")

assert d09b("./test/day09a.txt") == 2858
echo "Part 2: ", d09b("./inputs/day09.txt")
