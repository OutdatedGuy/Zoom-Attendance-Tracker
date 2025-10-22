flutter clean &&
flutter pub get &&

cd macos &&
pod install --repo-update &&
cd .. &&

rm -rf "installers/dmg_creator/Attendance Tracker for Zoom.app" &&

flutter build macos --release --obfuscate --split-debug-info="build/obfuscation-debug-symbols/macos";

cp -r "build/macos/Build/Products/Release/Attendance Tracker for Zoom.app/" "installers/dmg_creator/Attendance Tracker for Zoom.app" &&

open "installers/dmg_creator/";
