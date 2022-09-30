package utils

import (
	"os"
	"time"

	"github.com/rs/zerolog"
	"github.com/rs/zerolog/log"
)

func SetupLogger(verbose int) {
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
