#!/usr/bin/env bash

curl -o /tmp/sdc.tgz -L ${FULLTARBALL_URL}

tar xzf /tmp/sdc.tgz --strip-components 1 -C /opt/local/
