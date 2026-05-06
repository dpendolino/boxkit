BUILDER ?= podman
TAG     ?= latest

IMAGES := boxkit boxkit-alpine

.PHONY: all $(IMAGES) fedora-example clean

all: $(IMAGES)

boxkit:
	$(BUILDER) build -t boxkit:$(TAG) -f ContainerFiles/boxkit .

boxkit-alpine:
	$(BUILDER) build -t boxkit-alpine:$(TAG) -f ContainerFiles/boxkit-alpine .

fedora-example:
	$(BUILDER) build -t fedora-example:$(TAG) -f ContainerFiles/fedora-example .

clean:
	$(BUILDER) rmi --ignore boxkit:$(TAG) boxkit-alpine:$(TAG) fedora-example:$(TAG)
