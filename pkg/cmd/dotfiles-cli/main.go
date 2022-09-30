package main

import (
	"github.com/nemexur/dotfiles/pkg/cmd/dotfiles-cli/command"
)

const (
	Version      = "0.1.0"
	DotfilesRepo = "https://github.com/nemexur/dotfiles"
)

func main() {
	cli := command.NewCLI()
	cli.Init(Version, DotfilesRepo)
	cli.Execute()
}
