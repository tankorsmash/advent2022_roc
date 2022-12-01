interface Day1.Solution2
    exposes [name, solution]
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

name = "ASasdasd"

path = Path.fromStr "Day1/input.txt"



solveElf = \rawElf ->
    Str.split rawElf "\n"
    # ["123123", "2323"]
    |> List.map ((\i -> Str.toNat i |>  Result.withDefault 0))
    # [123123, 1231312]
    |> (\elves -> List.walk elves 0 (\elf,total -> elf + total))


solve : Str -> Str
solve = \contentsStr ->
    Str.split contentsStr "\n\n"
    |> List.map solveElf
    |> List.sortDesc
    # |> Num.toStr
    |> List.takeFirst 3
    |> (\elves -> List.walk elves 0 (\elf,total -> elf + total))
    |> Num.toStr

solution : Task {} []
solution =
    # # task : Task Str {}
    # # task : Str
    task =
        # cwd <- Env.cwd |> Task.await
        # cwdStr = Path.display cwd
        #
        # _ <- Stdout.line "cwd: \(cwdStr)" |> Task.await
        # dirEntries <- Dir.list cwd |> Task.await
        # contentsStr = Str.joinWith (List.map dirEntries Path.display) "\n    "
        File.readUtf8 path
    # task =
    #     contents <- Task.await (File.readUtf8 path)
    #     # contents
    #     # File.readUtf8 path
    #     when contents is
    #         Ok strContens -> strContens
    #         Err errContens -> "omg err"
    #     # "hello"
    #
    # # callback : Result a b -> Task Str {}
    # callback = \result ->
    #    when result is
    #         Ok anything -> "Ok printed ok"
    #         Err msg -> "Err ERRRRRR!"
    # printIfOk : Result {} * -> Str
    printIfOk = \result ->
        when result is
            Ok msg -> Stdout.line (solve msg)
            Err anythingElse ->
                # Stdout.line "Err"
                when anythingElse is
                    FileReadErr _pathErr readErr ->
                        Stdout.line (File.readErrToStr readErr)
                    FileReadUtf8Err _ _ ->
                        Stdout.line "utf8 err"

    #
    # Task.attempt task callback
    # Task.attempt (Task.succeed "ASD" ) printIfOk
    Task.attempt task printIfOk
