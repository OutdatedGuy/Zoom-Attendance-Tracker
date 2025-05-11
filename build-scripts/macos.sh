clear &&

flutter clean &&
flutter pub get &&

cd macos &&
pod install --repo-update &&
cd .. &&

flutter build macos --release &&

rm -f "installers/dmg_creator/dist/ZAT Installer.dmg" &&
npx appdmg "installers/dmg_creator/config.json" "installers/dmg_creator/dist/ZAT Installer.dmg" &&

open "installers/dmg_creator/dist/";
