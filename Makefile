USER = aialferov
PROJECT = pause

VERSION = $(shell cat Version)
GIT_SHA = $(shell git rev-parse HEAD | cut -c1-8)

PREFIX = usr/local

BUILD_DIR = _build
BUILD_DIR_IMAGE = $(BUILD_DIR)/image

BIN_DIR = bin
BIN_PATH = $(DEST_DIR)/$(PREFIX)/$(BIN_DIR)
BIN_PATH_IN = $(BUILD_DIR)/bin

all:
	mkdir -p $(BIN_PATH_IN)
	GOOS=$(PLATFORM) go build \
            -ldflags "-X main.version=$(VERSION) \
                      -X main.git_sha=$(GIT_SHA)" \
            -o $(BIN_PATH_IN)/$(PROJECT) src/$(PROJECT).go

run:
	$(BIN_PATH_IN)/$(PROJECT)

install:
	mkdir -p $(BIN_PATH)
	install -p $(BIN_PATH_IN)/$(PROJECT) $(BIN_PATH)

uninstall:
	rm -f $(BIN_PATH)/$(PROJECT)
	rmdir -p $(BIN_PATH) 2> /dev/null || true

clean:
	rm -f $(BIN_PATH_IN)/$(PROJECT)
	rmdir -p $(BIN_PATH_IN) 2> /dev/null || true

git-release:
	git tag -a v$(VERSION)
	git push origin v$(VERSION)

docker-build:
	$(MAKE) PLATFORM=linux
	$(MAKE) install DEST_DIR=$(BUILD_DIR_IMAGE) PREFIX=
	install -p -m 644 Dockerfile $(BUILD_DIR_IMAGE)
	docker build $(BUILD_DIR_IMAGE) -t $(USER)/$(PROJECT):$(VERSION)
	docker tag $(USER)/$(PROJECT):$(VERSION) $(USER)/$(PROJECT):latest

docker-push:
	docker push $(USER)/$(PROJECT):$(VERSION)
	docker push $(USER)/$(PROJECT):latest

docker-clean:
	rm -f $(BUILD_DIR_IMAGE)/Dockerfile
	$(MAKE) uninstall DEST_DIR=$(BUILD_DIR_IMAGE) PREFIX=

docker-clean-dangling:
	docker images -qf dangling=true | xargs docker rmi

docker-run:
	docker run --name $(PROJECT) --rm -it \
		$(USER)/$(PROJECT):$(VERSION) $(PROJECT)

docker-start:
	docker run --name $(PROJECT) --rm -d \
		$(USER)/$(PROJECT):$(VERSION) $(PROJECT)

docker-stop:
	docker stop $(PROJECT)

distclean: docker-clean clean

.PHONY: version
version:
	@echo "Version $(VERSION) (git-$(GIT_SHA))"
