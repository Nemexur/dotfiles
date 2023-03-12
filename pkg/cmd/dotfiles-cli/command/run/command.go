package run

import (
	"strings"

	"github.com/nemexur/dotfiles/pkg/ansible"
	"github.com/nemexur/dotfiles/pkg/system"
	"github.com/pkg/errors"
	"github.com/rs/zerolog/log"
	"github.com/spf13/cobra"
)

const example = `  # Run packages tasks.
  dotfiles run packages

  # Run packages and system tasks
  dotfiles run packages system

  # Run all tasks
  dotfiles run`

func NewCommand() *cobra.Command {
	var extraVars string
	cmd := &cobra.Command{
		Use:     "run [tag]...",
		Short:   "Run dotfiles management playbook. Requires user password.",
		Example: example,
		RunE: func(cmd *cobra.Command, args []string) error {
			ctx := cmd.Context()
			dotfilesDir, err := system.DotfilesDir()
			if err != nil {
				return err
			}
			// Install requirements with ansible-galaxy.
			// It is safe to run the command multiple times if requirements are installed.
			log.Debug().Msg("run: install requirements")
			if err := ansible.Galaxy(ctx, dotfilesDir); err != nil {
				return errors.Wrap(err, "run: ansible-galaxy failed")
			}
			// Run ansible-playbook with options
			var options []ansible.Option
			if tags := strings.Join(args, ","); tags != "" {
				options = append(options, ansible.Option{Key: "tags", Value: tags})
			}
			if extraVars != "" {
				options = append(options, ansible.Option{Key: "extra-vars", Value: extraVars})
			}
			log.Debug().Msg("run: ansible playbook")
			return ansible.Playbook(ctx, dotfilesDir, options)
		},
	}
	cmd.Flags().StringVarP(&extraVars, "extra-vars", "e", "", "set additional variables as key=value")
	return cmd
}
