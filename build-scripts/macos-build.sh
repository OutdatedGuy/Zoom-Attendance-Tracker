clear &&

flutter clean &&
flutter pub get &&

cd macos &&
pod install --repo-update &&
cd .. &&

rm -rf "installers/dmg_creator/Zoom Attendance Tracker.app" &&

flutter build macos --release;
