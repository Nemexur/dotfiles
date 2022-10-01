package main

import (
	"github.com/nemexur/dotfiles/pkg/cmd/dotfiles-cli/command"
	"github.com/rs/zerolog/log"
)

const (
	Version      = "0.1.0"
	DotfilesRepo = "https://github.com/nemexur/dotfiles"
)

func main() {
	cli := command.NewCLI()
	cli.Init(Version, DotfilesRepo)
	if err := cli.Execute(); err != nil {
		log.Fatal().Err(err).Msg("dotfiles: exited")
	}
}
