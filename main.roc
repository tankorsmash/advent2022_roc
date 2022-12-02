app "hello"
    packages { pf: "https://github.com/roc-lang/basic-cli/releases/download/0.1.1/zAoiC9xtQPHywYk350_b7ust04BmWLW00sjb9ZPtSQk.tar.br" }
    imports [
        pf.Stdout,
        pf.Task.{ Task },
        Day1.Solution2,
        Day2.Solution
    ]
    provides [main] to pf

main =
    Day2.Solution.solution
