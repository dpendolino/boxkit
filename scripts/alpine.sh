#!/bin/sh

/distrobox-shims.sh

apk update && apk upgrade
grep -v '^#' /alpine.packages | xargs apk add
