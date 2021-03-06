# RJSLibUF

__Guys love tools, this is my Swift toolbox (UIKit and Foundation )__

<p align="center">
   <a href="https://developer.apple.com/swift/">
      <img src="https://img.shields.io/badge/Swift-5.3-orange.svg?style=flat" alt="Swift 5.3">
   </a>
    <a href="https://developer.apple.com/swift/">
      <img src="https://img.shields.io/badge/Xcode-12.0.1-blue.svg" alt="Swift 5.3">
   </a>
   <a href="">
      <img src="https://img.shields.io/cocoapods/p/ValidatedPropertyKit.svg?style=flat" alt="Platform">
   </a>
   <br/>
   <a href="https://github.com/Carthage/Carthage">
      <img src="https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat" alt="Carthage Compatible">
   </a>
   <a href="https://github.com/apple/swift-package-manager">
      <img src="https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg" alt="SPM">
   </a>
   <a href="https://twitter.com/ricardo_psantos/">
      <img src="https://img.shields.io/badge/Twitter-@ricardo_psantos-blue.svg?style=flat" alt="Twitter">
   </a>
</p>


# Library Organization

There are 5 frameworks separated by business 

![Preview](Documents/readme.graf.png)

![Preview](Documents/readme.proj.png)

### RJSLibUFBase

RJSLibUFBase contains things like:

* Extensions
* Reachability manager
* App and device info utilities
* Generic utilities 
   * Chronometer
   * App Logger
   * Data types conversion tools
* Util classes
   * `SynchronizedArray`
* Others

---

### RJSLibUFStorage

RJSLibUFStorage includes storage helpers for:

* File handling
* CoreData
* Keychain
* NSUserDefaults utils
* Caching 
   * Hot cache using NSCache
   * Cold cache using CoreData


### RJSLibUFBaseVIP

VIP utils

---

### RJSLibUFAppThemes

Multiple design languages and color schemes.

---

### RJSLibUFDesignables

Util UI components/designables.

---

### RJSLibUFNetworking

WEB API clients.

---

# Install

### Install via Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate RJPSLibUB into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "ricardopsantos/RJSLibUF" "1.2.4"
```

or for beta

```ogdl
github "ricardopsantos/RJSLibUF" "master"
```

---

### Swift Package Manager

__Install using SPM On Xcode__

Add the following to your Package.swift file's dependencies:

`.package(url: "https://github.com/ricardopsantos/RJSLibUF.git", from: "1.2.4")`

And then import wherever needed

![Preview](Documents/readme.spm1.png)

---

__Install using SPM on XcodeGen__

```yml
packages:
  RJSLibUF:
    url: https://github.com/ricardopsantos/RJSLibUF
    branch: master
    #minVersion: 1.0.0, maxVersion: 2.0.0
    
targets:
  YourAppTargetName:
    type: application
    platform: iOS
    deploymentTarget: "13.0"
    sources:
       - path: ../YourAppSourcePath
    dependencies:
      - package: RJSLibUF
        product: RJSLibUFBase
        product: RJSLibUFStorage
        product: RJSLibUFNetworking
        product: RJSLibUFALayouts
        product: RJSLibUFAppThemes
```

---

__Install dependency on other SPM packages__

* Add the package `.package(name: "rjps-lib-uf", url: "https://github.com/ricardopsantos/RJSLibUF", from: "1.2.4")` (line 28)
* Declare the dependecies (line 14 and 19)
* Add the dependency
* 
![Preview](Documents/readme.spm3.png)

---      
        
__SPM Generic Usage__

![Preview](Documents/readme.spm2.png)

# 3 party code

[https://github.com/roberthein/TinyConstraints](https://github.com/roberthein/TinyConstraints)
