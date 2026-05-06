#!/bin/sh

/distrobox-shims.sh

apk update && apk upgrade
grep -v '^#' /boxkit-alpine.packages | xargs apk add
