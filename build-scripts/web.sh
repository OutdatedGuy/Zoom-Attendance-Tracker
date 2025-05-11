clear &&

flutter clean &&
flutter pub get &&

flutter build web --release --csp --source-maps --wasm &&

sed -i '' 's/"app_name":"attendance_tracker"/"app_name":"Zoom Attendance Tracker"/g' "build/web/version.json" &&

rm -f "installers/web/" &&
mkdir -p "installers/web/" &&

cp -R "build/web/" "installers/web/" &&

open "installers/web/";
