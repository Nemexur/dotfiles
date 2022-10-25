package command

import (
	"os"
	"time"

	"github.com/nemexur/dotfiles/pkg/cmd/dotfiles-cli/command/configure"
	"github.com/nemexur/dotfiles/pkg/cmd/dotfiles-cli/command/run"
	"github.com/nemexur/dotfiles/pkg/cmd/dotfiles-cli/command/task"
	"github.com/nemexur/dotfiles/pkg/system"
	"github.com/rs/zerolog"
	"github.com/rs/zerolog/log"
	"github.com/spf13/cobra"
)

type CLI struct {
	app *cobra.Command
}

func NewCLI() *CLI {
	app := &cobra.Command{
		Use:               "dotfiles",
		Short:             "Manage your dotfiles with ease",
		Long:              "CLI Tool to manage dotfiles configuration",
		SilenceUsage:      true,
		SilenceErrors:     true,
		CompletionOptions: cobra.CompletionOptions{DisableDefaultCmd: true},
	}
	return &CLI{app: app}
}

func (c *CLI) Execute() error {
	ctx, cancelF := system.NewContext()
	err := c.app.ExecuteContext(ctx)
	if err != nil {
		cancelF()
	}
	return err
}

func (c *CLI) Init(ver string, repo string) {
	c.app.Version = ver
	runCmd := run.NewCommand()
	configureCmd := configure.NewCommand(repo, func(cmd *cobra.Command, args []string) error {
		callF := func(f func(cmd *cobra.Command, args []string) error) error {
			if f == nil {
				return nil
			}
			return f(cmd, args)
		}
		if err := callF(runCmd.PreRunE); err != nil {
			return err
		}
		if err := callF(runCmd.RunE); err != nil {
			return err
		}
		if err := callF(runCmd.PostRunE); err != nil {
			return err
		}
		return nil
	})
	c.app.AddCommand(
		runCmd,
		configureCmd,
		task.NewCommand(),
	)
	var verbose int
	c.app.PersistentFlags().CountVarP(
		&verbose,
		"verbose",
		"v",
		"Log verbosity level. Adding multiple -v will increase the verbosity.",
	)
	cobra.OnInitialize(func() { setupLogger(verbose) })
}

func setupLogger(verbose int) {
	var level zerolog.Level
	switch verbose {
	case 0:
		level = zerolog.InfoLevel
	case 1:
		level = zerolog.DebugLevel
	default:
		level = zerolog.TraceLevel
	}
	log.Logger = zerolog.New(zerolog.ConsoleWriter{Out: os.Stdout, TimeFormat: time.RFC822}).
		Level(level).
		With().
		Timestamp().
		Logger()
}
