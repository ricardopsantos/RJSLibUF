#!/bin/bash

clear

displayCompilerInfo() {
    printf "\n"
    printf "\n"
    echo -n "### Current Compiler"
    printf "\n"
    eval xcrun swift -version
    eval xcode-select --print-path
}

################################################################################

echo "### Brew"
echo " [1] : Install"
echo " [2] : Update"
echo " [3] : Skip"
echo -n "Option? "
read option
case $option in
    [1] ) /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" ;;
    [2] ) eval brew update ;;
   *) echo "Ignored...."
;;
esac

################################################################################

printf "\n"

echo "### Periphery"
echo " [1] : Install"
echo " [2] : Update"
echo " [3] : Skip"
echo -n "Option? "
read option
case $option in
    [1] ) brew tap peripheryapp/periphery && brew install periphery ;;
    [2] ) eval brew update ;;
   *) echo "Ignored...."
;;
esac

################################################################################

printf "\n"

echo "### Xcodegen"
echo " [1] : Install"
echo " [2] : Upgrade"
echo " [3] : No/Skip"
echo -n "Option? "
read option
case $option in
    [1] ) brew install xcodegen ;;
    [2] ) brew upgrade xcodegen ;;
   *) echo "Ignored...."
;;
esac

################################################################################

displayCompilerInfo

printf "\n"
printf "\n"

################################################################################

echo "### Clean DerivedData?"
echo " [1] : Yes"
echo " [2] : No/Skip"
echo -n "Option? "
read option
case $option in
    [1] ) rm -rf ~/Library/Developer/Xcode/DerivedData/* ;;
   *) echo "Ignored...."
;;
esac

printf "\n"
printf "\n"

################################################################################

echo "### Kill Xcode?"
echo " [1] : No/Skip"
echo " [2] : Yes"
echo -n "Option? "
read option
case $option in
    [1] ) echo "Ignored...." ;;
   *) killall Xcode
;;
esac

################################################################################

printf "\n"
printf "\n"

echo 'Xcodegen...'
echo 'Generating RJSLibUF.xcodeproj for carthage install...'
xcodegen -s ./XcodeGen/RJSLibUF.yml -p ./
echo 'Done!'

echo 'Generating iOSSampleApp.xcodeproj with RJSLibUF installed via SPM...'
xcodegen -s ./XcodeGen/iOSSampleApp.yml -p ./
echo 'Done!'

#open RJSLibUF.xcodeproj
#open iOSSampleApp.xcodeproj

echo ''

echo 'Xcodegen graphviz...'
xcodegen dump --spec ./XcodeGen/RJSLibUF.yml --type graphviz --file ./Documents/Graph.viz
xcodegen dump --spec ./XcodeGen/RJSLibUF.yml --type json     --file ./Documents/Graph.json
echo 'done!'

################################################################################

printf "\n"

echo "### periphery scan?"
echo " [1] : Yes"
echo " [2] : No/Skip"
echo -n "Option? "
read option
case $option in
    [1] ) periphery scan ;;
   *) echo "Ignored...."
;;
esac


################################################################################

echo " ╔═══════════════════════╗"
echo " ║ Done! You're all set! ║"
echo " ╚═══════════════════════╝"
