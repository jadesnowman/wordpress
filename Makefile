PROJECT = wordpress
NAME = registry.ilhamjs.io/$(PROJECT)
ARCH ?= amd64
VERSION = 0.0.1-$(ARCH)

.PHONY: build build-nocache tag-latest push push-latest release git-tag-version

build:
	docker build --build-arg GITHUB_PERSONAL_ACCESS_TOKEN=${GITHUB_PERSONAL_ACCESS_TOKEN} -f Dockerfile -t $(NAME):$(VERSION) --platform=linux/$(ARCH) --rm .

tag-latest:
	docker tag $(NAME):$(VERSION) $(NAME):$(ARCH)-latest

push:
	docker push $(NAME):$(VERSION)

push-latest:
	docker push $(NAME):$(ARCH)-latest

release: build tag-latest push push-latest

git-tag-version: release
	git tag -a v$(VERSION) -m "v$(VERSION)"
