#!/bin/bash

export GEM_HOME=`pwd`/kotlin/build/gems
echo "gems_home=$GEM_HOME"

# build/gems内のパスであることを確認する
export PATH="$GEM_HOME/bin:$PATH"
echo "rails_path=`which rails`"

# 引数をそのまま渡す
rails ${@+"$@"}
