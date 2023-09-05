APP=$(shell basename $(shell git remote get-url origin))
REGISTRY=ghcr.io/flameflashy
VERSION=$(shell git describe --tags --abbrev=0)$(shell git rev-parse --short HEAD)
TARGETOS=linux #linux darwin windows
TARGETARCH=amd64 #arm64

format:
	gofmt -s -w ./

lint:
	golint

test:
	go test -v

get:
	go get

build: format get
	CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -v -o k_prom_bot -ldflags "-X="github.com/FlameFlashy/k_prom_bot/cmd.appVersion=${VERSION}

image:
	docker build . -t ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}

push: 
	docker push ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}


clean:
	rm -rf k_prom_bot
	docker rmi ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}