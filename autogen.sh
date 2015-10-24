#!/bin/sh
set -ex

autoreconf -f -i -Wall
./configure
