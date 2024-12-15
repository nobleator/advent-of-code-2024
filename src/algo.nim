import std/sequtils

func generatePermutations*(ops: seq[char], length: int, current: seq[char], result: var seq[seq[char]]) =
    if len(current) == length:
        result.add(current)
    else:
        for o in ops:
            var newSeq = current
            newSeq.add(o)
            generatePermutations(ops, length, newSeq, result)

func getPermutations*(ops: seq[char], length: int): seq[seq[char]] =
    var res: seq[seq[char]] = @[]
    generatePermutations(ops, length, @[], res)
    return res

iterator pairwise*[T](sequence: seq[T]): seq[T] =
    for i in 0..len(sequence)-1:
        for j in i+1..len(sequence)-1:
            yield @[sequence[i], sequence[j]]