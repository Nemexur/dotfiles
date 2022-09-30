package manager

import (
	"context"
	"fmt"
	"os"
	"os/exec"
	"runtime"

	"github.com/nemexur/dotfiles/pkg/utils"
	"github.com/rs/zerolog/log"
)

const (
	brewInstallScript = "https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh"
	brewLinuxBinary   = "/home/linuxbrew/.linuxbrew/bin"
)

type Brew struct {
	name string
}

func NewBrew() Brew {
	return Brew{name: "brew"}
}

func (b Brew) Install(ctx context.Context) error {
	if b.executableExists() {
		log.Info().Msg("brew already installed")
		return nil
	}
	cmd := exec.CommandContext(ctx, "/bin/bash", "-c", fmt.Sprintf("$(curl -fsSL %s)", brewInstallScript))
	utils.PipeOs(cmd)
	return cmd.Run()
}

func (b Brew) Do(ctx context.Context, args ...string) error {
	if !b.executableExists() {
		return fmt.Errorf("%s executable not found", b.name)
	}
	cmd := exec.CommandContext(ctx, b.name, args...)
	utils.PipeOs(cmd)
	return cmd.Run()
}

func (b Brew) executableExists() bool {
	lookup := func() bool {
		p, _ := exec.LookPath(b.name)
		return p != ""
	}
	if runtime.GOOS == "linux" && !lookup() {
		v := fmt.Sprintf("%s:%s", os.Getenv("PATH"), brewLinuxBinary)
		os.Setenv("PATH", v)
	}
	return lookup()
}
