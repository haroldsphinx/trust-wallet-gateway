BINARY_NAME=trust-wallet-gateway
BUILD_DIR=./build/bin
IMAGE=haroldsphinx/trust-wallet-gateway

all: build-app docker-build

build-app:
	go build -o $(BINARY_NAME) main.go 
	mkdir -p $(BUILD_DIR)
	mv $(BINARY_NAME) $(BUILD_DIR)

docker-build:
	docker buildx build --platform linux/amd64 -t $(IMAGE) .
