app "AOC2022"
    packages { pf: "https://github.com/roc-lang/basic-cli/releases/download/0.2.0/8tCohJeXMBUnjo_zdMq0jSaqdYoCWJkWazBd4wa8cQU.tar.br" }
    imports [
        pf.Stdout,
        pf.Process,
        pf.Task.{ Task },
        pf.Arg,
        # Day1.Solution2,
        # Day2.Solution
    ]
    provides [main] to pf

dividendConfig =
    Arg.i64Option {
        long: "dividend",
        short: "n",
        help: "the number to divide; corresponds to a numerator",
    }

divisorConfig =
    Arg.i64Option {
        long: "divisor",
        short: "d",
        help: "the number to divide by; corresponds to a denominator",
    }

parser =
    divCmd =
        Arg.succeed
            (
                \dividend ->
                    \divisor ->
                        Div (Num.toF64 dividend) (Num.toF64 divisor)
            )
        |> Arg.withParser dividendConfig
        |> Arg.withParser divisorConfig
        |> Arg.subCommand "div"

    Arg.choice [divCmd]
    |> Arg.program { name: "args-example", help: "A calculator example of the CLI platform argument parser" }

main : Task {} []
main =
    args <- Arg.list |> Task.await

    when Arg.parseFormatted parser args is
        Ok cmd ->
            runCmd cmd
            |> Num.toStr
            |> Stdout.line

        Err helpMenu ->
            {} <- Stdout.line helpMenu |> Task.await
            Process.exit 1

runCmd = \cmd ->
    when cmd is
        Div n d -> n / d
        Log b n ->
            runCmd (Div (Num.log n) (Num.log b))
