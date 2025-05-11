clear &&

flutter clean &&
flutter pub get &&

flutter build appbundle --release &&

rm -f "installers/android/appbundle/Zoom Attendance Tracker.aab" &&
mkdir -p "installers/android/appbundle/" &&

cp -R "build/app/outputs/bundle/release/app-release.aab" "installers/android/appbundle/Zoom Attendance Tracker.aab" &&

open "installers/android/appbundle/";
