package utils

import (
	"os"
	"os/exec"
)

// PipeOs connects os.Stdin, os.Stdout, os.Stderr to exec.Command.
func PipeOs(cmd *exec.Cmd) {
	cmd.Stdin = os.Stdin
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
}
