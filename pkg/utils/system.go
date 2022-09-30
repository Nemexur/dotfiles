package utils

import (
	"context"
	"errors"
	"os"
	"os/signal"
	"syscall"

	"github.com/rs/zerolog/log"
)

func DotfilesDir() (string, error) {
	dir, ok := os.LookupEnv("DOTFILES")
	if !ok {
		return "", errors.New("DOTFILES env is not found")
	}
	return dir, nil
}

// NewSystemContext returns new context.Context and context.CancelFunc, which will be called,
// when system interrupt signal is received.
func NewSystemContext() (context.Context, context.CancelFunc) {
	ctx, cancelF := context.WithCancel(context.Background())
	go listenToSystemSignals(ctx, cancelF)
	return ctx, cancelF
}

func listenToSystemSignals(ctx context.Context, cancelF context.CancelFunc) {
	signalChan := make(chan os.Signal, 1)
	signal.Notify(signalChan, syscall.SIGQUIT, syscall.SIGINT, syscall.SIGTERM)
	select {
	case <-ctx.Done():
	case s := <-signalChan:
		log.Debug().Msgf("os signal received: %[1]d (%[1]s)", s)
		cancelF()
	}
}
