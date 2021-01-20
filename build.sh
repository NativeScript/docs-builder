#!/bin/bash

BUILD_DIR=$(pwd)/ns-docs
DIST_DIR=$(pwd)/dist

echo "Building NativeScript docs"

# Clean
echo "Cleaning..."
rm -rf $BUILD_DIR $DIST_DIR

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
mkdir $BUILD_DIR

# V6 ##############################
echo "Building v6.x docs"
cd $BUILD_DIR
mkdir v6; cd v6

clone "docs" "v6.x"
clone "nativescript-angular"
clone "NativeScript" "tns-core-modules"
clone "nativescript-sdk-examples-js"
clone "nativescript-sdk-examples-ng"
clone "nativescript-cli"
clone "nativescript-ui-samples"
clone "nativescript-ui-samples-angular"
clone "nativescript-ui-samples-vue"

echo "Prepared build dir for v6:"
ls -al

export Version=6.0
./docs/build/site-container/build.sh

mkdir $DIST_DIR/v6
cp -r ./docs/build/bin/site $DIST_DIR/v6
cp ./docs/build/bin/site/start/landing.html $DIST_DIR/v6/site/index.html
cp ./docs/version.json $DIST_DIR/v6/site
# END V6 ##########################


# V7 ##############################
echo "Building v7.x docs"
cd $BUILD_DIR
mkdir v7; cd v7

clone "docs"
clone "nativescript-angular"
clone "NativeScript" "feat/ns7-docs" # todo: remove branch when merged
clone "nativescript-sdk-examples-js"
clone "nativescript-sdk-examples-ng"
clone "nativescript-cli"
clone "nativescript-ui-samples"
clone "nativescript-ui-samples-angular"
clone "nativescript-ui-samples-vue"

echo "Prepared build dir for v7:"
ls -al

export Version=7.0
./docs/build/site-container/build.sh

mkdir $DIST_DIR/v7
cp -r ./docs/build/bin/site $DIST_DIR/v7
cp ./docs/build/bin/site/start/landing.html $DIST_DIR/v7/site/index.html
cp ./docs/version.json $DIST_DIR/v7/site
# END V7 ##########################

echo "Build complete."
