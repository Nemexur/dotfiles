package ansible

import (
	"context"
	"os"
	"os/exec"
)

const (
	requirements  = "requirements.yaml"
	ansibleGalaxy = "ansible-galaxy"
)

func Galaxy(ctx context.Context, dotfilesDir string) error {
	cmd := exec.CommandContext(ctx, ansibleGalaxy, "install", "--role-file", requirements)
	cmd.Dir = dotfilesDir
	cmd.Stdin = os.Stdin
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	return cmd.Run()
}
