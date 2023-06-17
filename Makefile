VERSION=$(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)
TARGETOS=linux

format:
	gofmt -s -w ./

lint:
	golint

test:
	go test -v

build: format
	CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${shell dpkg --print-architecture} go build -v -o k_prom_bot -ldflags "-X="github.com/FlameFlashy/k_prom_bot/cmd.appVersion=${VERSION}

clean:
	rm -rf k_prom_bot