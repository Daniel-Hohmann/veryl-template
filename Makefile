# Docker Image Name und Tag
IMAGE_NAME := veryl-dev
IMAGE_TAG := latest

# Container Name
CONTAINER_NAME := veryl-dev-container

# Hilfe anzeigen
help:
	@echo "Verfügbare Befehle:"
	@echo "  make build     - Baut das Veryl Dev-Image"
	@echo "  make run       - Startet interaktiven Container (mountet aktuelles Verzeichnis)"
	@echo "  make dev       - Baut und startet Container"
	@echo "  make stop      - Stoppt den Container"
	@echo "  make clean     - Entfernt Container und Image"
	@echo "  make veryl     - Führt 'veryl --version' im Container aus"

# Image bauen
build:
	docker build -t $(IMAGE_NAME):$(IMAGE_TAG) .

# Container interaktiv starten (Volume-Mount für Code)
run:
	docker run -it --rm \
		--name $(CONTAINER_NAME) \
		-v $$PWD:/workspace \
		-w /workspace \
		$(IMAGE_NAME):$(IMAGE_TAG)

# Build + Run (Dev-Shortcut)
dev: build run

# Container stoppen
stop:
	docker stop $(CONTAINER_NAME) || true

# Cleanup
clean:
	docker stop $(CONTAINER_NAME) || true
	docker rm $(CONTAINER_NAME) || true
	docker rmi $(IMAGE_NAME):$(IMAGE_TAG) || true

# Veryl Version checken
veryl:
	docker run --rm $(IMAGE_NAME):$(IMAGE_TAG) veryl --version

.PHONY: help build run dev stop clean veryl

