#!/bin/bash

DIST_DIR=$(pwd)/dist

echo "Building NativeScript docs"

# Clean
echo "Cleaning..."
rm -rf ns-docs $DIST_DIR

clone() {
  # Checkout specific branch if specified
  if [ -z "$2" ]; then
    git clone --depth 1 "https://github.com/NativeScript/$1.git"
  else
    echo "Cloning branch $2..."
    git clone --single-branch --branch $2 "https://github.com/NativeScript/$1.git"
  fi
}

# Prerequisites #####################
# npm i
# export PATH=$(pwd)/node_modules/.bin:$PATH

# BUILD START #######################
mkdir $DIST_DIR
mkdir ns-docs; pushd ns-docs

  # V6 ##############################
  echo "Building v6.x docs"
  mkdir v6; pushd v6

    clone "docs" "v6.x"
    clone "nativescript-angular"
    clone "NativeScript" "tns-core-modules"
    clone "nativescript-sdk-examples-js"
    clone "nativescript-sdk-examples-ng"
    clone "nativescript-cli"
    clone "nativescript-ui-samples"
    clone "nativescript-ui-samples-angular"
    clone "nativescript-ui-samples-vue"

    export Version=6.0
    ./docs/build/site-container/build.sh

    mkdir $DIST_DIR/v6
    cp -r ./docs/build/bin/site $DIST_DIR/v6
    cp ./docs/build/bin/site/start/landing.html $DIST_DIR/v6/site/index.html
    cp ./docs/version.json $DIST_DIR/v6/site

  popd
  # END V6 ##########################


  # V7 ##############################
  echo "Building v7.x docs"
  mkdir v7; pushd v7

    clone "docs"
    clone "nativescript-angular"
    clone "NativeScript" "feat/ns7-docs" # todo: remove branch when merged
    clone "nativescript-sdk-examples-js"
    clone "nativescript-sdk-examples-ng"
    clone "nativescript-cli"
    clone "nativescript-ui-samples"
    clone "nativescript-ui-samples-angular"
    clone "nativescript-ui-samples-vue"


    export Version=7.0
    ./docs/build/site-container/build.sh

    mkdir $DIST_DIR/v7
    cp -r ./docs/build/bin/site $DIST_DIR/v7
    cp ./docs/build/bin/site/start/landing.html $DIST_DIR/v7/site/index.html
    cp ./docs/version.json $DIST_DIR/v7/site

  popd
  # END V7 ##########################

popd
# BUILD END #########################

echo "Build complete."
