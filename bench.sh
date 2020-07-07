#!/usr/bin/env bash

docker build -t test-skewheap .
docker run -it test-skewheap janet ./bench.janet
