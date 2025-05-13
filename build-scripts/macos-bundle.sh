clear &&

rm -f "installers/dmg_creator/dist/ZAT Installer.dmg" &&
mkdir -p "installers/dmg_creator/dist" &&

npx appdmg "installers/dmg_creator/config.json" "installers/dmg_creator/dist/ZAT Installer.dmg" &&

open "installers/dmg_creator/dist/";
