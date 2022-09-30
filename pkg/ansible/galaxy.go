package ansible

import (
	"context"
	"os/exec"

	"github.com/nemexur/dotfiles/pkg/utils"
)

const (
	requirements  = "requirements.yaml"
	ansibleGalaxy = "ansible-galaxy"
)

func Galaxy(ctx context.Context, dotfilesDir string) error {
	cmd := exec.CommandContext(ctx, ansibleGalaxy, "install", "--role-file", requirements)
	cmd.Dir = dotfilesDir
	utils.PipeOs(cmd)
	return cmd.Run()
}
