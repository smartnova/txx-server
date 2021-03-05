#!/bin/sh

cd ~wakita/lib/js

dl() {
  echo "######################################################################"
  echo "Downloading $1"
  wget $2
}

dl d3 https://github.com/d3/d3/releases/download/v6.5.0/d3.zip
