interface Day2.Solution
    exposes [solution]
    imports [
        # pf.Process,
        pf.Stdout,
        # pf.Stderr,
        pf.Task.{ Task },
        pf.File,
        pf.Path,
        # pf.Env,
        # pf.Dir,
    ]

path = Path.fromStr "Day2/input.txt"

RPS : [Rock, Paper, Scissors]

GameResult : [Win, Draw, Loss]

scoreRPS : RPS -> I32
scoreRPS = \rps ->
    when rps is
        Rock -> 1
        Paper -> 2
        Scissors -> 3

# scoreGameResult : GameResult -> Int
scoreGameResult = \gameResult ->
    when gameResult is
        Win -> 6
        Draw -> 3
        Loss -> 0

toRPS : Str -> RPS
toRPS = \char ->
    when char is
        "A" | "X" -> Rock
        "B" | "Y" -> Paper
        "C" | "Z" -> Scissors
        _ -> Rock

calcResult : RPS, RPS -> GameResult
calcResult = \you, them ->
    when [you, them] is
        [Rock, Rock] -> Draw
        [Paper, Paper] -> Draw
        [Scissors, Scissors] -> Draw
        [Rock, Scissors] -> Win
        [Scissors, Paper] -> Win
        [Paper, Rock] -> Win
        [Scissors, Rock] -> Loss
        [Paper, Scissors] -> Loss
        [Rock, Paper] -> Loss
        _ -> crash "impossible"

calc : List RPS -> I32
calc = \rpses ->
    when rpses is
        [leftRPS, rightRPS] ->
            result = calcResult leftRPS rightRPS
            scoredResult = scoreGameResult result
            scoredRPS = scoreRPS leftRPS
            scoredRPS + scoredResult

        [_] -> -100
        [_, _, _] -> -1000
        [] -> -10000
        _ -> -100000

solveElf : Str -> I32
solveElf = \rawElf ->
    Str.split rawElf " " # ["A" "Z"]
    |> List.map toRPS
    |> calc
# # ["123123", "2323"]
# |> List.map ((\i -> Str.toNat i |>  Result.withDefault 0))
# # [123123, 1231312]
# |> (\elves -> List.walk elves 0 (\elf,total -> elf + total))

solve : Str -> Str
solve = \contentsStr ->
    dbg
        "wtf"

    Str.split contentsStr "\n"
    |> List.map solveElf # |> List.sortDesc
    # |> List.takeFirst 3
    |> List.sum
    |> Num.toStr

# solution : Task Str {}
solution =
    task =
        File.readUtf8 path

    printIfOk = \result ->
        when result is
            Ok msg -> Task.succeed (solve msg)
            Err anythingElse ->
                when anythingElse is
                    FileReadErr _pathErr readErr ->
                        Task.succeed (File.readErrToStr readErr)

                    FileReadUtf8Err _ _ ->
                        Task.succeed ("utf8 err")

    Task.attempt task printIfOk
