import XCTest
import class Foundation.Bundle

// swiftlint:disable all

@testable import RJSLibUFBase
@testable import RJSLibUFStorage
@testable import RJSLibUFAppThemes
@testable import RJSLibUFALayouts
@testable import RJSLibUFNetworking

private let tKey: String = "XCTestCase_key"
private let tValue: String = "XCTestCase_value"
private let tImageURL: String = "https://www.google.pt/images/branding/googlelogo/1x/googlelogo_white_background_color_272x92dp.png"
private let tJSONURL: String = "http://dummy.restapiexample.com/api/v1/employees"

class RJSLibUFTests: XCTestCase {

    static var allTests = [
        ("test_Device", test_Device)
    ]

    // MARK: - Device

    func test_Device() {
        #if !os(macOS)
        XCTAssert(!RJS_DeviceInfo.appOnBackground)
        XCTAssert(RJS_DeviceInfo.uuid.length>0)
        XCTAssert(RJS_DeviceInfo.deviceInfo.count>0)
        XCTAssert(RJS_DeviceInfo.isSimulator)
        #endif
    }

    // MARK: - Storage

    func test_StorableKeyValue() {
        _ = RJS_StorableKeyValue.clean()
        XCTAssert(RJS_StorableKeyValue.allKeys().count == 0)
        _ = RJS_StorableKeyValue.save(key: tKey, value: tValue)
        XCTAssert(RJS_StorableKeyValue.allKeys().count == 1)
        XCTAssert(RJS_StorableKeyValue.allRecords().count == 1)
        XCTAssert(RJS_StorableKeyValue.with(key: tKey) != nil)
        XCTAssert(RJS_StorableKeyValue.with(key: tKey)?.value == tValue)
        XCTAssert(RJS_StorableKeyValue.with(key: tKey)?.recordDate != nil)
        XCTAssert(RJS_StorableKeyValue.with(key: tKey)?.expireDate != nil)
        XCTAssert(RJS_StorableKeyValue.existsWith(key: tKey))
        XCTAssert(RJS_StorableKeyValue.with(keyPrefix: tKey) != nil)
        _ = RJS_StorableKeyValue.deleteWith(key: tKey)
        XCTAssert(!RJS_StorableKeyValue.existsWith(key: tKey))
    }

    func test_LiveCache() {
        RJS_HotCache.shared.clean()
        RJS_HotCache.shared.add(object: tValue as AnyObject, withKey: tKey)
        let valueA = RJS_HotCache.shared.get(key: tKey) as? String
        XCTAssert(valueA == tValue)
        RJS_HotCache.shared.clean()
        let valueB = RJS_HotCache.shared.get(key: tKey) as? String
        XCTAssert(valueB == nil)
    }

    func test_PersistentCacheWithTTL() {

        let expectation = self.expectation(description: #function)

        struct SomeCodableEmployee: Codable {
            let name: String
            enum CodingKeys: String, CodingKey {
                case name
            }
        }

        RJS_ColdCache.shared.clean()
        XCTAssert(RJS_ColdCache.shared.allRecords().count == 0)

        _ = RJS_ColdCache.shared.saveObject(SomeCodableEmployee(name: "Joe"), withKey: tKey, keyParams: [], lifeSpam: 0)
        let value1 = RJS_ColdCache.shared.getObject(SomeCodableEmployee.self, withKey: tKey, keyParams: [])
        XCTAssert(value1 == nil)

        RJS_ColdCache.shared.clean()

        _ = RJS_ColdCache.shared.saveObject(SomeCodableEmployee(name: "Joe"), withKey: tKey, keyParams: [], lifeSpam: 1)
        let value2 = RJS_ColdCache.shared.getObject(SomeCodableEmployee.self, withKey: tKey, keyParams: [])
        XCTAssert(value2 != nil)
        XCTAssert(RJS_ColdCache.shared.allRecords().count == 1)

        _ = RJS_ColdCache.shared.saveObject(SomeCodableEmployee(name: "Joe"), withKey: tKey, keyParams: ["1"], lifeSpam: 1)
        let value3 = RJS_ColdCache.shared.getObject(SomeCodableEmployee.self, withKey: tKey, keyParams: [])
        XCTAssert(value3 != nil)
        XCTAssert(value3?.name == "Joe")
        XCTAssert(RJS_ColdCache.shared.allRecords().count == 2)

        _ = RJS_ColdCache.shared.saveObject(SomeCodableEmployee(name: "Joe"), withKey: tKey, keyParams: ["1"], lifeSpam: 1)
        XCTAssert(RJS_ColdCache.shared.allRecords().count == 2)

        expectation.fulfill()

        waitForExpectations(timeout: 5)

    }

    func test_Storages_DefaultsVars() {
        let someIntA = 100
        RJSLib.Storages.NSUserDefaultsStoredVarUtils.setIntWithKey(tKey, value: someIntA)
        XCTAssert(RJSLib.Storages.NSUserDefaultsStoredVarUtils.getIntWithKey(tKey) == someIntA)
        XCTAssert(RJSLib.Storages.NSUserDefaultsStoredVarUtils.decrementIntWithKey(tKey) == someIntA-1)
        RJSLib.Storages.NSUserDefaultsStoredVarUtils.setIntWithKey(tKey, value: someIntA)
        XCTAssert(RJS_UserDefaultsVars.incrementIntWithKey(tKey) == someIntA+1)
        RJS_UserDefaults.deleteWith(key: tKey)
        XCTAssert(!RJS_UserDefaults.existsWith(key: tKey))
        RJS_UserDefaults.save(tValue as AnyObject, key: tKey)
        let value = RJS_UserDefaults.getWith(key: tKey) as? String
        XCTAssert(value == tValue)
        XCTAssert(RJS_UserDefaults.existsWith(key: tKey))
        RJS_UserDefaults.deleteWith(key: tKey)
        XCTAssert(!RJS_UserDefaults.existsWith(key: tKey))
    }

    func test_Logs() {
        RJS_Logs.message("Regular log")
        RJS_Logs.warning("Warning log")
        RJS_Logs.error("Error log")
    }

    func test_Utils() {
        RJS_Utils.assert(true)
        RJS_Utils.assert(true, message: "")
        _ = RJS_Utils.existsInternetConnection
        _ = RJS_Utils.isRealDevice
        _ = RJS_Utils.onDebug
        _ = RJS_Utils.onRelease
        _ = RJS_Utils.isSimulator
        _ = RJS_Utils.senderCodeId()
    }

    func test_AppInfo() {
        #if !os(macOS)
        _ = RJS_AppInfo.appOnBackground
        _ = RJS_AppInfo.isInLowPower
        _ = RJS_AppInfo.iPadDevice
        _ = RJS_AppInfo.iPhoneDevice
        #endif
        _ = RJS_AppInfo.isSimulator
    }

    func test_Files() {
        let fileName1 = "File1.txt"
        let fileName2 = "File2.txt"
        let content1   = "content_1"
        let content2   = "content_2"
        func doTestIn(folder: RJS_Files.Folder) {
            RJS_Files.clearFolder(folder)
            XCTAssert(RJS_Files.appendToFile(fileName1, toAppend: content1, folder: folder, overWrite: true))
            XCTAssert(RJS_Files.readContentOfFile(fileName1, folder: folder) == content1)
            RJS_Files.appendToFile(fileName1, toAppend: content2, folder: folder, overWrite: false)
            XCTAssert(RJS_Files.readContentOfFile(fileName1, folder: folder) == "\(content1)\(content2)")
            XCTAssert(RJS_Files.fileNamesInFolder(folder).contains(fileName1))
            XCTAssert(RJS_Files.deleteFile(fileName1, folder: folder))
            XCTAssert(!RJS_Files.fileNamesInFolder(folder).contains(fileName1))
            RJS_Files.clearFolder(folder)
            RJS_Files.appendToFile(fileName1, toAppend: content1, folder: folder, overWrite: true)
            RJS_Files.appendToFile(fileName2, toAppend: content1, folder: folder, overWrite: true)
            XCTAssert(RJS_Files.fileNamesInFolder(folder).count == 2)
        }
        doTestIn(folder: .documents)
        //doTestIn(folder: .temp)
    }

    func test_KeyChain() {
        RJS_Keychain.shared.delete(key: tKey)
        XCTAssert(RJS_Keychain.shared.get(key: tKey) == nil)
        XCTAssert(!RJS_Keychain.shared.add(tValue, withKey: ""))
        XCTAssert(!RJS_Keychain.shared.add(tValue, withKey: " "))
        XCTAssert(RJS_Keychain.shared.add(tValue, withKey: tKey))
        XCTAssert(RJS_Keychain.shared.get(key: tKey) == tValue)
        RJS_Keychain.shared.delete(key: tKey)
        XCTAssert(RJS_Keychain.shared.get(key: tKey) == nil)
    }

    func test_FilesImages() {
        #if !os(macOS)
        let expectation = self.expectation(description: #function)
        let imageName = "someImage"
        func doTestIn(folder: RJS_Files.Folder, image: UIImage) {
            XCTAssert(RJS_Files.saveImageWith(name: imageName, folder: folder, image: image))
            if let image = RJS_Files.imageWith(name: imageName) {
                XCTAssert(image.size.height > 0)
                XCTAssert(image.size.width > 0)
                XCTAssert(image.size.height != image.size.width)
            } else {
                XCTAssert(false)
            }
        }

        RJS_BasicNetworkClient.downloadImageFrom(tImageURL, caching: .cold) { (image) in
            XCTAssert(image != nil)
            doTestIn(folder: .documents, image: image!)
            doTestIn(folder: .temp, image: image!)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5)
        #endif
    }

    func test_NetworkClient() {
        let expectation = self.expectation(description: #function)

        struct Employee: Codable {
            // https://app.quicktype.io/
            let identifier, employeeName, employeeSalary, employeeAge: String
            let profileImage: String
            enum CodingKeys: String, CodingKey {
                case identifier     = "id"
                case employeeName   = "employee_name"
                case employeeSalary = "employee_salary"
                case employeeAge    = "employee_age"
                case profileImage   = "profile_image"
            }
        }

        struct APIRequest: RJS_SimpleNetworkClientRequestProtocol {
            var returnOnMainTread: Bool = false
            var debugRequest: Bool = true
            var urlRequest: URLRequest
            var responseType: RJS_SimpleNetworkClientResponseType
            var mockedData: String? = """
[{"id":"36253","employee_name":"Mike Cooper","employee_salary":"80","employee_age":"23","profile_image":""},{"id":"36255","employee_name":"Eldon","employee_salary":"9452","employee_age":"66","profile_image":""}]
"""
            init() throws {
                if let url = URL(string: tJSONURL) {
                    urlRequest            = URLRequest(url: url)
                    urlRequest.httpMethod = RJS_SimpleNetworkClient.HttpMethod.get.rawValue
                    responseType          = .json
                } else {
                    throw NSError(domain: "com.example.error", code: 0, userInfo: nil)
                }
            }
        }
        do {
            typealias EmployeeList = [Employee]
            let apiRequest: RJS_SimpleNetworkClientRequestProtocol = try APIRequest()
            let api: SimpleNetworkClient_Protocol = RJS_SimpleNetworkClient()
            api.execute(request: apiRequest, completionHandler: { (result: Result<RJS_SimpleNetworkClientResponse<EmployeeList>>) in
                switch result {
                case .success(let some):
                    let employeeList = some.entity
                    XCTAssert(employeeList.count > 0)
                    XCTAssert(employeeList.first!.identifier.count > 0)
                case .failure: XCTAssert(false)
                }
                expectation.fulfill()
            })
        } catch {
            XCTAssert(false)
        }
        waitForExpectations(timeout: 5)
    }

    func test_BasicNetworkClient() {
        let expectation = self.expectation(description: #function)
        RJS_BasicNetworkClient.getDataFrom(urlString: tImageURL) { (data, success) in
            XCTAssert(data != nil)
            XCTAssert(success)
            RJS_BasicNetworkClient.getJSONFrom(urlString: tJSONURL, completion: { (some, success) in
                XCTAssert(some != nil)
                XCTAssert(success)
                #if !os(macOS)
                RJS_BasicNetworkClient.downloadImageFrom(tImageURL, completion: { (image) in
                    XCTAssert(image != nil)
                    expectation.fulfill()
                })
                #else
                expectation.fulfill()
                #endif
            })
        }
        waitForExpectations(timeout: 5)
    }

    func test_RJSCronometer() {
        #if !os(macOS)
        let operationId = "operationId"
        _ = RJS_Cronometer.printTimeElapsedWhenRunningCode(operationId) { }
        _ = RJS_Cronometer.timeElapsedInSecondsWhenRunningCode { }
        RJS_Cronometer.startTimerWith(identifier: operationId)
        [1...1000].forEach { (_) in }
        XCTAssert(RJS_Cronometer.timeElapsed(identifier: operationId, print: false)! > 0.0)
        #endif
    }

    func test_Convert() {
        let plain = "Hello"
        let b64   = "SGVsbG8="
        XCTAssert(RJS_Convert.Base64.isBase64(b64))
        XCTAssert(RJS_Convert.Base64.toPlainString(b64)==plain)
        XCTAssert(RJS_Convert.Base64.toB64String(plain as AnyObject)==b64)
        XCTAssert(RJS_Convert.Base64.toB64String(Data(plain.utf8) as AnyObject)==b64)
    }

    func test_AES() {
        let mySecret  = AES256CBC.randomText(500)
        let encripted = mySecret.aesEncrypt()
        XCTAssert(encripted.aesDecrypt() ==  mySecret)
        XCTAssert("lalalala".aesDecrypt() == "")
    }

    func test_TreadingMisc() {
        let expectation = self.expectation(description: #function)
        RJS_Utils.executeInMainTread { XCTAssert(Thread.isMainThread) }
        RJS_Utils.executeInBackgroundTread { XCTAssert(!Thread.isMainThread) }
        var operationBlockWasExecuted = false
        let operationId = "operationId"
        let wasExecuted1 = RJS_Utils.executeOnce(token: operationId) {
            operationBlockWasExecuted = true
        }

        let wasExecuted2 = RJS_Utils.executeOnce(token: operationId) {
            XCTAssert(false)
        }
        XCTAssert(wasExecuted1)
        XCTAssert(!wasExecuted2)
        XCTAssert(operationBlockWasExecuted)

        DispatchQueue.executeWithDelay {
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5)
    }

    func test_StringExtensions() {
        let word = "Hello"
        XCTAssert(word.first=="H")
        XCTAssert(word.last=="o")
        XCTAssert(" \(word) ".trim==word)
        XCTAssert(word.reversed=="olleH")
        XCTAssert(word.contains(subString: "ll"))
        XCTAssert(!word.contains(subString: "x"))
        XCTAssert(word.split(by: "l").count==3)
        XCTAssert(word.split(by: "x").count==1)
        XCTAssert(word.replace(word, with: "")=="")
    }
}
