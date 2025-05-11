clear &&

flutter clean &&
flutter pub get &&

flutter build apk --release &&

rm -f "installers/android/apk/Zoom Attendance Tracker.apk" &&
mkdir -p "installers/android/apk/" &&

cp -R "build/app/outputs/flutter-apk/app-release.apk" "installers/android/apk/Zoom Attendance Tracker.apk" &&

open "installers/android/apk/";
