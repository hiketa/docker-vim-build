#IMAGE:=fedora:36
IMAGE:=rockylinux:9
#IMAGE:=ubuntu:22.04
TARGET_DIR:=/usr/local/vim

.PHONY: build
build:
	docker container run --rm -v $(PWD):/build:ro -v $(TARGET_DIR):$(TARGET_DIR):rw $(IMAGE) /build/build.sh
	sudo ln -vfs /usr/local/vim/bin/* /usr/local/bin/
