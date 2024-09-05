package main

import (
   "fmt"
   "os"
   "os/exec"
)

func main() {
   fmt.Printf("In main function")
    cmd := exec.Command("/bin/sh","/usr/local/bin/run-app")
    out, err := cmd.CombinedOutput()
    cmd.Stdout = os.Stdout
    if err != nil {
        fmt.Printf("\nFailed to execute command with error is %s\n", err.Error())

    }

}
