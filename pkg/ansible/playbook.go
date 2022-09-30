package ansible

import (
	"context"
	"fmt"
	"os/exec"

	"github.com/nemexur/dotfiles/pkg/utils"
	"github.com/rs/zerolog/log"
)

const (
	playbook        = "main.yaml"
	ansiblePlaybook = "ansible-playbook"
)

type Option struct {
	Key   string
	Value string
}

func Playbook(ctx context.Context, dotfilesDir string, opts []Option) error {
	return run(ctx, playbook, dotfilesDir, opts)
}

func Task(ctx context.Context, tasks []string, dotfilesDir string, opts []Option) error {
	for _, task := range tasks {
		log.Debug().Msgf("running %s", task)
		if err := run(ctx, task, dotfilesDir, opts); err != nil {
			return err
		}
	}
	return nil
}

func run(ctx context.Context, name string, dotfilesDir string, opts []Option) error {
	args := []string{name}
	for _, opt := range opts {
		args = append(args, fmt.Sprintf("--%s", opt.Key), opt.Value)
	}
	cmd := exec.CommandContext(ctx, ansiblePlaybook, args...)
	cmd.Dir = dotfilesDir
	utils.PipeOs(cmd)
	return cmd.Run()
}
