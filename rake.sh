#!/bin/bash

export GEM_HOME=`pwd`/kotlin/build/gems
echo "gems_home=$GEM_HOME"

# build/gems内のパスであることを確認する
export PATH="$GEM_HOME/bin:$PATH"
echo "rake_path=`which rake`"

# 引数をそのまま渡す
rake ${@+"$@"}
