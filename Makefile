# ホスト上のインストール先ディレクトリ。
TARGET_DIR:=/usr/local/vim
# Docker用のボリュームマウント指定。
VOLUME_DOCKER:=$(TARGET_DIR):/usr/local/vim:rw
# Podman用のボリュームマウント指定。:zは適切なSELinuxラベルを付与してくれる。
VOLUME_PODMAN:=$(TARGET_DIR):/usr/local/vim:z
# 実際に使用するボリュームマウント指定。
VOLUME:=$(VOLUME_PODMAN)

.PHONY: build
build:
	sudo docker image build -t vim-builder:latest .
	sudo docker container run \
		--rm \
		-v $(VOLUME) \
		vim-builder:latest
	sudo ln -vfs $(TARGET_DIR)/bin/* /usr/local/bin/
