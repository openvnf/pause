package main

import (
    "fmt"
    "os"
    "os/signal"
    "time"
    "syscall"
)

var version string
var git_sha string

const VersionFormat = "Version %s (git-%s)\n"
const TsFormat = "2006-01-02T15:04:05.999Z"

func main() {
    if len(os.Args) > 1 && os.Args[1] == "version" {
        fmt.Printf(VersionFormat, version, git_sha)
        os.Exit(0)
    }

    c := make(chan os.Signal, 1)
    signal.Notify(c, os.Interrupt,
                     syscall.SIGTERM, syscall.SIGINT, syscall.SIGCHLD)
    <-c

    fmt.Printf("I%s: Done.\n", time.Now().UTC().Format(TsFormat))
}
