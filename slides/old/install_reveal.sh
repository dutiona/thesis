#!/bin/bash

#Pandoc 2.9.2.1 and earlier must use reveal.js 3.x:
#VER="4.3.0"
VER="3.9.2"

if [[ ! -d reveal.js ]]; then
  mkdir -p reveal.js
  wget https://github.com/hakimel/reveal.js/archive/refs/tags/${VER}.zip
  mv ${VER}.zip reveal.js
  cd reveal.js
  unzip -o ${VER}.zip
  mv reveal.js-${VER}/* .
  rm -rf ${VER}.zip reveal.js-${VER}
fi
