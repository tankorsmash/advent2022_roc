app "hello"
    packages { pf: "https://github.com/roc-lang/basic-cli/releases/download/0.1.1/zAoiC9xtQPHywYk350_b7ust04BmWLW00sjb9ZPtSQk.tar.br" }
    imports [pf.Stdout, pf.Task.{ Task }, Day1.Solution2]
    provides [main] to pf

main =
    Day1.Solution2.solution
    # body <- when Day1.Solution2.solution is
    #      Ok msg ->
    #          # Stdout.line msg
    #          "ok body"
    #      Err errMsg ->
    #          # Stdout.line errMsg
    #          "err body"
    # Task.attempt body Stdout.line
