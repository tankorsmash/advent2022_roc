app "AOC2022"
    packages { pf: "https://github.com/roc-lang/basic-cli/releases/download/0.2.0/8tCohJeXMBUnjo_zdMq0jSaqdYoCWJkWazBd4wa8cQU.tar.br" }
    imports [
        pf.Stdout,
        pf.Process,
        pf.Task.{ Task },
        pf.Arg,
        Day1.Solution2,
        Day2.Solution,
    ]
    provides [main] to pf

dayConfig =
    Arg.i64Option {
        long: "day",
        short: "d",
        help: "The Advent of Code 2022 day to run",
    }

partConfig =
    Arg.i64Option {
        long: "part",
        short: "p",
        help: "which part of the day's challenge (usually 1 or 2)",
    }

parser =
    divCmd =
        Arg.succeed
            (
                \dayNum ->
                    \partNum ->
                        Day (dayNum) (Part (partNum))
            )
        |> Arg.withParser dayConfig
        |> Arg.withParser partConfig
        |> Arg.subCommand "div"

    Arg.choice [divCmd]
    |> Arg.program { name: "args-example", help: "A calculator example of the CLI platform argument parser" }

main : Task {} []
main =
    args <- Arg.list |> Task.await

    when Arg.parseFormatted parser args is
        Ok cmd ->
            # ranTask : Task Str []
            # ranTask = runCmd cmd
            {} <- runCmd cmd

            # res <- ranTask |> Task.await

            Task.await ranTask Stdout.line
            Process.exit 1

        Err helpMenu ->
            helpTask : Task {} []
            helpTask = Stdout.line helpMenu

            {} <- helpTask |> Task.await

            Process.exit 1

runCmd = \cmd ->

    t : Task Str []
    t =
        when cmd is
            Day dayNum (Part partNum) ->
                when dayNum is
                    1 ->
                        Day1.Solution2.solution

                    2 ->
                        Day2.Solution.solution

                    _ ->
                        dbg
                            "asdad"

                        Task.succeed "ASD"
    t

