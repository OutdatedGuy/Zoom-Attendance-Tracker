flutter clean &&
flutter pub get &&

flutter build appbundle --release --obfuscate --split-debug-info="build/obfuscation-debug-symbols/android" &&

rm -f "installers/android/appbundle/Attendance Tracker for Zoom.aab" &&
mkdir -p "installers/android/appbundle/" &&

cp -R "build/app/outputs/bundle/release/app-release.aab" "installers/android/appbundle/Attendance Tracker for Zoom.aab" &&

open "installers/android/appbundle/";
