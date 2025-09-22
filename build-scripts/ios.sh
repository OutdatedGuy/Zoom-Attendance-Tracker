flutter clean &&
flutter pub get &&

cd ios &&
pod install --repo-update &&
cd .. &&

flutter build ipa --release --obfuscate --split-debug-info="build/obfuscation-debug-symbols/ios" &&

rm -f "installers/ios/Zoom Attendance Tracker.ipa" &&
mkdir -p "installers/ios/" &&

cp -R "build/ios/ipa/zoom_tracker.ipa" "installers/ios/Zoom Attendance Tracker.ipa" &&

open "installers/ios/";
