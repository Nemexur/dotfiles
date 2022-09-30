package configure

import (
	"context"
	"os"
	"path/filepath"
	"time"

	"github.com/go-git/go-git/v5"
	"github.com/nemexur/dotfiles/pkg/manager"
	"github.com/pkg/errors"
	"github.com/rs/zerolog/log"
	"github.com/spf13/cobra"
)

const (
	countdown       = 5
	countdownTicker = 1 * time.Second
	waitTime        = 3 * time.Second
)

func NewCommand(repo string, bootstrapCmd func(cmd *cobra.Command, args []string) error) *cobra.Command {
	return &cobra.Command{
		Use:   "configure",
		Short: "Configure your system with dotfiles very first time",
		Args:  cobra.NoArgs,
		PreRunE: func(cmd *cobra.Command, args []string) error {
			ctx := cmd.Context()
			log.Info().Msg("configure: welcome to nemexur dotfiles")
			log.Info().Msg("configure: this script installs and configures everything very first time")
			ticker := time.NewTicker(countdownTicker)
			for c := countdown; c > 0; c-- {
				log.Info().Msgf("configure: begins in %d", c)
				select {
				case <-ticker.C:
				case <-ctx.Done():
					ticker.Stop()
					return errors.New("configure: cancelled")
				}
			}
			return nil
		},
		RunE: func(cmd *cobra.Command, args []string) error {
			ctx := cmd.Context()
			log.Info().Msg("configure: starting...")
			time.Sleep(waitTime)
			log.Info().Msg("configure: installing brew")
			brew := manager.NewBrew()
			if err := brew.Install(ctx); err != nil {
				return errors.Wrap(err, "configure: brew install failed")
			}
			log.Debug().Msg("configure: updating brew")
			if err := brew.Do(ctx, "update"); err != nil {
				return errors.Wrap(err, "configure: brew update failed")
			}
			log.Debug().Msg("configure: installing ansible")
			if err := brew.Do(ctx, "install", "python@3.9", "ansible"); err != nil {
				return errors.Wrap(err, "configure: install ansible failed")
			}
			path := filepath.Join(os.Getenv("HOME"), ".dotfiles")
			if err := os.Setenv("DOTFILES", path); err != nil {
				return err
			}
			log.Info().Msgf("configure: pulling dotfiles at %s...", path)
			return installDotfiles(ctx, path, repo)
		},
		PostRunE: func(cmd *cobra.Command, args []string) error {
			log.Info().Msg("configure: starting dotfiles bootstrap...")
			time.Sleep(waitTime)
			return bootstrapCmd(cmd, args)
		},
	}
}

func installDotfiles(ctx context.Context, path, repo string) error {
	if stat, err := os.Stat(path); err == nil && stat.IsDir() {
		log.Info().Msg("configure: dotfiles already installed")
		return nil
	}
	_, err := git.PlainCloneContext(ctx, path, false, &git.CloneOptions{
		URL:          repo,
		Progress:     os.Stdout,
		SingleBranch: false,
	})
	return err
}
