#!/bin/sh

mkdir -p ~wakita/lib/js/arc
cd ~wakita/lib/js/arc

dl() {
  echo "######################################################################"
  echo "Downloading $1"
  wget $2
}

dl d3 https://github.com/d3/d3/releases/download/v6.5.0/d3.zip
dl c3 https://github.com/c3js/c3/archive/v0.7.20.zip
dl jQuery https://code.jquery.com/jquery-3.6.0.min.js
dl underscore https://underscorejs.org/underscore-min.js
dl fontawesome https://use.fontawesome.com/releases/v5.15.2/js/all.js
