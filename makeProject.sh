
clear

echo 'Xcodegen...'
echo 'Generating RJSLibUF.xcodeproj for carthage install...'
xcodegen -s ./XcodeGen/project.yml -p ./
echo 'Done!'

echo 'Generating iOSSampleApp with RJSLibUF installed via SPM...'
xcodegen -s ./XcodeGen/iOSSampleApp.yml -p ./
echo 'Done!'

#open RJSLibUF.xcodeproj
open iOSSampleApp.xcodeproj

echo ''

echo 'Xcodegen graphviz...'
cd XcodeGen
xcodegen dump --type graphviz --file ../Documents/Graph.viz
xcodegen dump --type json --file ../Documents/Graph.json
echo 'done!'


