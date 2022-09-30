package task

import (
	"errors"
	"fmt"
	"os"
	"path/filepath"

	"github.com/nemexur/dotfiles/pkg/ansible"
	"github.com/nemexur/dotfiles/pkg/utils"
	"github.com/rs/zerolog/log"
	"github.com/spf13/cobra"
)

const example = `  # Run remove-venv task
  dotfiles task remove-venv

  # Run update-cli and remove-venv tasks
  dotfiles task update-cli remove-venv`

func NewCommand() *cobra.Command {
	var (
		extraVars   string
		dotfilesDir string
	)
	cmd := &cobra.Command{
		Use:     "task name...",
		Short:   "Run specific dotfiles task",
		Example: example,
		Args: func(cmd *cobra.Command, args []string) error {
			if len(args) == 0 {
				return errors.New("task: args are required")
			}
			for _, task := range args {
				p := filepath.Join(dotfilesDir, "tasks", fmt.Sprintf("%s.yaml", task))
				if stat, err := os.Stat(p); err != nil || stat.IsDir() {
					return fmt.Errorf("task: invalid task %s", task)
				}
			}
			return nil
		},
		PreRunE: func(cmd *cobra.Command, args []string) (err error) {
			dotfilesDir, err = utils.DotfilesDir()
			return
		},
		RunE: func(cmd *cobra.Command, args []string) error {
			ctx := cmd.Context()
			var tasks []string
			for _, task := range args {
				tasks = append(tasks, filepath.Join("tasks", fmt.Sprintf("%s.yaml", task)))
			}
			var options []ansible.Option
			if extraVars != "" {
				options = append(options, ansible.Option{Key: "extra-vars", Value: extraVars})
			}
			log.Debug().Msg("task: run ansible playbook")
			return ansible.Task(ctx, tasks, dotfilesDir, options)
		},
	}
	cmd.Flags().StringVarP(&extraVars, "extra-vars", "e", "", "set additional variables as key=value")
	return cmd
}
