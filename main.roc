app "AOC2022"
    packages { pf: "https://github.com/roc-lang/basic-cli/releases/download/0.2.0/8tCohJeXMBUnjo_zdMq0jSaqdYoCWJkWazBd4wa8cQU.tar.br" }
    imports [
        # pf.Stdout,
        pf.Task.{ Task },
        pf.Arg,
        # Day1.Solution2,
        Day2.Solution
    ]
    provides [main] to pf

main : Task {} []
main =
    args <- Arg.list |> Task.await
    Day2.Solution.solution
