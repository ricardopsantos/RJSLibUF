
clear

echo 'Xcodegen...'
echo 'Generating RJSLibUF.xcodeproj for carthage install...'
xcodegen -s ./XcodeGen/RJSLibUF.yml -p ./
echo 'Done!'

echo 'Generating iOSSampleApp.xcodeproj with RJSLibUF installed via SPM...'
xcodegen -s ./XcodeGen/iOSSampleApp.yml -p ./
echo 'Done!'

echo 'Generating iOSSampleAppWTinyConstraints.xcodeproj with RJSLibUF and TinyConstraints installed via SPM...'
xcodegen -s ./XcodeGen/iOSSampleAppWTinyConstraints.yml -p ./
echo 'Done!'

#open RJSLibUF.xcodeproj
#open iOSSampleApp.xcodeproj

echo ''

echo 'Xcodegen graphviz...'
xcodegen dump --spec ./XcodeGen/RJSLibUF.yml --type graphviz --file ./Documents/Graph.viz
xcodegen dump --spec ./XcodeGen/RJSLibUF.yml --type json     --file ./Documents/Graph.json
echo 'done!'

#cat ../Documents/Graph.json


