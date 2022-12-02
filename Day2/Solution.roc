interface Day2.Solution
    exposes [solution]
    imports [
        pf.Process,
        pf.Stdout,
        pf.Stderr,
        # pf.Task.{ Task },
        pf.File,
        pf.Path,
        pf.Env,
        pf.Dir,
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
    #Draws
    if you == Rock && them == Rock then
        Draw
    else if you == Paper && them == Paper then
        Draw
    else if you == Scissors && them == Scissors then
        Draw
    else if you == Rock && them ==  Scissors then Win
    else if you == Scissors && them ==  Paper then Win
    else if you == Paper && them ==  Rock then Win

    else if you == Scissors && them == Rock then Loss
    else if you == Paper && them == Scissors then Loss
    else if you == Rock && them == Paper then Loss

    else
        Win
    # when ( you, them ) is
    #     (Rock, Rock) -> Draw
    #     (Paper, Paper) -> Draw
    #     (Scissors, Scissors) -> Draw
    #
    #     (Rock, Scissors) -> Win
    #     (Scissors, Paper) -> Win
    #     (Paper, Rock) -> Win
    #
    #     (Scissors, Rock) -> Loss
    #     (Paper, Scissors) -> Loss
    #     (Rock, Paper) -> Loss


calc : List RPS -> I32
calc = \rpses ->
        when rpses is
            [leftRPS, rightRPS] ->
                result = (calcResult leftRPS rightRPS)
                scoredResult = scoreGameResult result
                scoredRPS = scoreRPS leftRPS
                scoredRPS + scoredResult
            [left] -> -100
            [left, right, other] -> -1000
            [] -> -10000
            _ -> -100000

solveElf : Str -> I32
solveElf = \rawElf ->
    Str.split rawElf " "
    # ["A" "Z"]
    |> List.map toRPS
    |> calc
    # # ["123123", "2323"]
    # |> List.map ((\i -> Str.toNat i |>  Result.withDefault 0))
    # # [123123, 1231312]
    # |> (\elves -> List.walk elves 0 (\elf,total -> elf + total))
    


solve : Str -> Str
solve = \contentsStr ->
    dbg 1
    "wtf"
    # Str.split contentsStr "\n"
    # |> List.map solveElf
    # # |> List.sortDesc
    # # |> List.takeFirst 3
    # |> List.sum
    # |> Num.toStr

solution : Task {} []
solution =
    task =
        File.readUtf8 path

    printIfOk = \result ->
        when result is
            Ok msg -> Stdout.line (solve msg)
            Err anythingElse ->
                when anythingElse is
                    FileReadErr _pathErr readErr ->
                        Stdout.line (File.readErrToStr readErr)
                    FileReadUtf8Err _ _ ->
                        Stdout.line "utf8 err"

    Task.attempt task printIfOk
