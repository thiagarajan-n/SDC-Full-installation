#!/usr/bin/env bash

curl -o /tmp/sdc.tgz -L http://archives.streamsets.com/datacollector/3.6.0/tarball/streamsets-datacollector-core-3.6.0.tgz

tar xzf /tmp/sdc.tgz --strip-components 1 -C /opt/local/
