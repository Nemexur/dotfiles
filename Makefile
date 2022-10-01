REPO?=github.com/nemexur/dotfiles
CLI_PATH?=/usr/local/bin/dotfiles
GO_FLAGS?=CGO_CPPFLAGS="-I/usr/include" CGO_LDFLAGS="-L/usr/lib -lpthread -lrt -lstdc++ -lm -lc -lgcc" CGO_ENABLED=0


all: help

help:
	@echo "Commands:"
	@awk 'match($$0, "^#>") { sub(/^#>/, "", $$0); doc=$$0; getline; split($$0, c, ":"); cmd=c[1]; print "\033[00;32m"cmd"\033[0m"":"doc }' Makefile | column -t -s ":" | awk '{ print "  "$$0 }'

#> Install cli
cli: go-mod go-build

#> Update go dependencies
go-mod:
	@go get -u ./...

#> Build dotfiles-cli
go-build:
	$(GO_FLAGS) go build -o $(CLI_PATH) $(REPO)/pkg/cmd/dotfiles-cli

# Prepare development environment
setup:
	ansible-galaxy install --role-file requirements.yaml -vvv

#> Run linters
lint: yaml-lint go-lint

#> Run linters for yaml and ansible files
yaml-lint:
	@echo "[ \033[00;33mYamllint\033[0m ]"
	yamllint .
	@echo "[ \033[00;33mAnsible-lint\033[0m ]"
	ansible-lint

#> Run linters for go files
go-lint:
	@echo "[ \033[00;33mGoLangCI-Lint\033[0m ]"
	golangci-lint run ./...
	@echo "[ \033[00;33mStaticCheck\033[0m ]"
	staticcheck ./...
