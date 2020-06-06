SHELL := /bin/bash

IMAGE_NAME := udondan/html-to-pdf
IMAGE_VERSION := $(shell cat VERSION)

build:
	@docker build . -t ${IMAGE_NAME}:${IMAGE_VERSION}
	@docker tag ${IMAGE_NAME}:${IMAGE_VERSION} ${IMAGE_NAME}:latest

test:
	docker run --workdir /github/workspace --rm \
		-e INPUT_HTMLFILE="example.html" \
		-e INPUT_OUTPUTFILE="example.pdf" \
		-e INPUT_PDFOPTIONS='{"format": "A4", "margin": {"top": "10mm", "left": "10mm", "right": "10mm", "bottom": "10mm"}}' \
		-v "$(shell pwd)":"/github/workspace" \
		${IMAGE_NAME}:${IMAGE_VERSION}

tag:
	@git tag -a "v$(IMAGE_VERSION)" -m 'Creates tag "v$(IMAGE_VERSION)"'
	@git push --tags

untag:
	@git push --delete origin "v$(IMAGE_VERSION)"
	@git tag --delete "v$(IMAGE_VERSION)"

release: tag

re-release: untag tag
