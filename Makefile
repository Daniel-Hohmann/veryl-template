# Docker image name and tag
IMAGE_NAME ?= veryl-dev
IMAGE_TAG ?= latest

# Show help
.PHONY: help
help:
	@echo "Available commands:"
	@echo "  make build              - Build with VeryL (Ubuntu 24.04 + Rust + VeryL)"
	@echo "  make run                - Start standard container (VeryL only)"
	@echo "  make clean              - Remove images"

# Standard build (VeryL always included, Ubuntu 24.04 + Rust)
.PHONY: build
build:
	docker build --progress=plain -t $(IMAGE_NAME):$(IMAGE_TAG) .
	@echo "✓ VeryL image built: $(IMAGE_NAME):$(IMAGE_TAG)"

# Start standard container (always has VeryL)
.PHONY: run
run:
	docker run -it --rm -v $$PWD:/workspace -w /workspace $(IMAGE_NAME):$(IMAGE_TAG)

# Cleanup
.PHONY: clean
clean:
	docker rmi $(IMAGE_NAME):$(IMAGE_TAG) $(IMAGE_NAME):rggen || true
	@echo "✓ Old images removed"
