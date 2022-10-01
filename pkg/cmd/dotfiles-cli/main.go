package main

import (
	"fmt"
	"time"

	"github.com/nemexur/dotfiles/pkg/cmd/dotfiles-cli/command"
	"github.com/rs/zerolog/log"
)

const (
	Version      = "0.1.0"
	DotfilesRepo = "https://github.com/nemexur/dotfiles"
)

func main() {
	version := fmt.Sprintf("%s-%s", Version, time.Now().Format(time.RFC3339))
	cli := command.NewCLI()
	cli.Init(version, DotfilesRepo)
	if err := cli.Execute(); err != nil {
		log.Fatal().Err(err).Msg("dotfiles: exited")
	}
}
