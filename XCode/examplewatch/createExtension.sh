rm -r examplewatch/
xcodebuild -project examplewatch.xcodeproj -target wkexample\ Extension -configuration release -sdk watchos -arch arm64_32 -arch armv7k BUILD_DIR=build BUILD_ROOT=build
xcodebuild -project examplewatch.xcodeproj -target wkexample\ Extension -configuration release -sdk watchsimulator -arch i386 BUILD_DIR=build BUILD_ROOT=build
mkdir "WatchKitExtension.appex"
lipo -create -output "WatchKitExtension.appex/WatchKitExtension" "build/Release-watchos/wkexample Extension.appex/wkexample Extension" "build/Release-watchsimulator/wkexample Extension.appex/wkexample Extension"
cp build/Release-watchos/wkexample\ Extension.appex/Info.plist WatchKitExtension.appex
codesign -f -s - "WatchKitExtension.appex"
##Return init state.
git checkout .
rm -r build
mv WatchKitExtension.appex ../../Robovm/examplewatch/libs/