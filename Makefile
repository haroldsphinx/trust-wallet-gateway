BINARY_NAME=trust-wallet-gateway
BUILD_DIR=./build/bin
IMAGE=haroldsphinx/trust-wallet-gateway
TF_DIR=./terraform


all: build-app docker-build

install-dependencies:	
	@echo "  >  Installing dependencies"
	# Install golangci-lint
	brew install golangci/tap/golangci-lint

lint:
	@echo "  >  Running Lint"
	@golangci-lint run ./...

test:
	@echo "  >  Running tests"
	@go test -v ./...

build-app:
	go build -o $(BINARY_NAME) main.go 
	mkdir -p $(BUILD_DIR)
	mv $(BINARY_NAME) $(BUILD_DIR)

docker-build:
	@echo "  >  Building docker image"
	@docker buildx build --platform linux/amd64 -t $(IMAGE) .

terraform-init:
	cd $(TF_DIR) && terraform init

terraform-plan:
	cd $(TF_DIR) && terraform plan

terraform-apply:
	cd $(TF_DIR) && terraform apply