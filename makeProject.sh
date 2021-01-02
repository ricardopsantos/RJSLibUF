
clear

echo 'Xcodegen...'
xcodegen -s ./XcodeGen/project.yml -p ./
echo '50% done!'
xcodegen -s ./XcodeGen/project2.yml -p ./
echo '100% done!'

#open RJSLibUF.xcodeproj
open SPMInstalled_SampleProject.xcodeproj

echo ''

echo 'Xcodegen graphviz...'
cd XcodeGen
xcodegen dump --type graphviz --file ../Documents/Graph.viz
xcodegen dump --type json --file ../Documents/Graph.json
echo 'done!'


