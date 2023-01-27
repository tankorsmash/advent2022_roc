interface Day1.Solution2
    exposes [solution]
    imports [
        pf.Process,
        pf.Stdout,
        pf.Stderr,
        pf.Task.{ Task },
        pf.File,
        pf.Path,
        pf.Env,
        pf.Dir,
    ]

path = Path.fromStr "Day1/input.txt"

solveElf = \rawElf ->
    Str.split rawElf "\n" # ["123123", "2323"]
    |> List.map (\i -> Str.toNat i |> Result.withDefault 0) # [123123, 1231312]
    |> (\elves -> List.walk elves 0 (\elf, total -> elf + total))

solve : Str -> Str
solve = \contentsStr ->
    Str.split contentsStr "\n\n"
    |> List.map solveElf
    |> List.sortDesc
    |> List.takeFirst 3
    |> (\elves -> List.walk elves 0 (\elf, total -> elf + total))
    |> Num.toStr

IOError : [ReadErr, WriteErr]
FileError : [FileReadErr, FileReadUtf8Err]

# solution : Task Str []
solution =
    # task : Task Str IOError
    task =
        File.readUtf8 path

    # printIfOk : Result Str _ -> Str
    printIfOk = \result ->
        (
            when result is
                Ok msg -> solve msg
                Err errorType ->
                    when errorType is
                        FileReadErr _pathErr readErr ->
                            File.readErrToStr readErr

                        FileReadUtf8Err _ _ ->
                            "utf8 err"
        )
        |> Task.succeed

    Task.attempt task printIfOk
