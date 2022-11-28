#! /bin/bash

exec podman run --userns=keep-id --privileged \
    -v ${PWD}:/vulkan:z -w /vulkan -it --rm \
    khronosgroup/docker-images:asciidoctor-spec "$@"
