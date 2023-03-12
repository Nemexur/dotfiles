package ansible

import (
	"context"
	"fmt"
	"os"
	"os/exec"

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
	// Always ask for become password
	args := []string{name, "-K"}
	for _, opt := range opts {
		args = append(args, fmt.Sprintf("--%s", opt.Key), opt.Value)
	}
	log.Debug().Msgf("command: %s %+v", ansiblePlaybook, args)
	cmd := exec.CommandContext(ctx, ansiblePlaybook, args...)
	cmd.Dir = dotfilesDir
	cmd.Stdin = os.Stdin
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	return cmd.Run()
}
