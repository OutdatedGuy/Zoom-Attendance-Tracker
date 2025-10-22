flutter clean &&
flutter pub get &&

cd ios &&
pod install --repo-update &&
cd .. &&

flutter build ipa --release --obfuscate --split-debug-info="build/obfuscation-debug-symbols/ios" &&

rm -f "installers/ios/Attendance Tracker for Zoom.ipa" &&
mkdir -p "installers/ios/" &&

cp -R "build/ios/ipa/zoom_tracker.ipa" "installers/ios/Attendance Tracker for Zoom.ipa" &&

open "installers/ios/";
