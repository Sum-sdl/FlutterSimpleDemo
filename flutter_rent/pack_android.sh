#!/usr/bin/env bash
echo "Clean old build"
find . -d -name "build" | xargs rm -rf
flutter clean

echo "Get packages"
flutter packages get

echo "Build release AOT"
flutter build aot --release

echo "Build release Bundle"
flutter build bundle --precompiled --asset-dir=build/flutteroutput/flutter_assets

# 拷贝flutter.jar
echo 'Copy flutter jar'
mkdir -p android/packflutter/flutter/flutter/android-arm-release && cp /Users/sdl/DevelopSdk/Flutter/bin/cache/artifacts/engine/android-arm-release/flutter.jar "$_"


# 拷贝asset
#  include "vm_snapshot_data"
#        include "vm_snapshot_instr"
#        include "isolate_snapshot_data"
#        include "isolate_snapshot_instr"
echo 'Copy flutter asset'
mkdir -p android/packflutter/flutter/assets/release && cp build/aot/* "$_"

mkdir -p android/packflutter/flutter/assets/release/flutter_assets && cp -r build/flutteroutput/flutter_assets/* "$_"

 #将flutter库和flutter_app打成aar 同时publish到Ali-maven
echo 'Build and publish idle fish flutter to aar'
cd android
if [ -n "$1" ]
then
    ./gradlew :packflutter:clean :packflutter:publish -PAAR_VERSION=$1
else
    ./gradlew :packflutter:clean :packflutter:publish
fi
cd ../