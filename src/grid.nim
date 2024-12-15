import std/strutils

type
  Row* = seq[char]
  Grid* = seq[Row]

# Handy for debugging, not needed for the actual solution
proc printGrid*(grid: Grid): string =
    for row in grid:
        echo row.join("")

func `+`*(a, b: (int, int)): (int, int) =
    result = (a[0] + b[0], a[1] + b[1])

func `-`*(a, b: (int, int)): (int, int) =
    result = (a[0] - b[0], a[1] - b[1])

func gridContains*(grid: Grid, point: (int, int)): bool =
    point[0] >= 0 and point[0] < len(grid) and point[1] >= 0 and point[1] < len(grid[0])

func get*(grid: Grid, point: (int, int)): char =
    grid[point[0]][point[1]]