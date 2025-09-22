flutter clean &&
flutter pub get &&

cd macos &&
pod install --repo-update &&
cd .. &&

rm -rf "installers/dmg_creator/Zoom Attendance Tracker.app" &&

flutter build macos --release --obfuscate --split-debug-info="build/obfuscation-debug-symbols/macos";

cp -r "build/macos/Build/Products/Release/Zoom Attendance Tracker.app/" "installers/dmg_creator/Zoom Attendance Tracker.app" &&

open "installers/dmg_creator/";
