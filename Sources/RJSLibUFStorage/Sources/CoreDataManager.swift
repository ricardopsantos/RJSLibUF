//
//  Created by Ricardo P Santos on 2019.
//  Copyright © 2019 Ricardo P Santos. All rights reserved.
//

import Foundation
import CoreData
#if !os(macOS)
import UIKit
#endif
//
import RJSLibUFBase

private class BundleFinder { }

extension RJSLib {

    public class CoreDataManager {

        static var dbName: String { return "RJPSLibDataModel" }

        private static var managedObjectModel: NSManagedObjectModel? = {
            func tryNSManagedObjectModelFrom(bundle: Bundle) -> NSManagedObjectModel? {
                if let modelURL = bundle.url(forResource: dbName, withExtension: "momd") {
                    return NSManagedObjectModel(contentsOf: modelURL)!
                }
                return nil
            }

            //
            // Bundle should be present here when the package installed via Carthage
            //
            if let bundle = Bundle(identifier: "com.rjps.libuf.RJSLibUFStorage"),
               let managedObjectModel = tryNSManagedObjectModelFrom(bundle: bundle) {
                return managedObjectModel
            }

            // Bundle should be present here when the package installed via SwiftPackageManager
            let candidates = [
                Bundle.main.resourceURL,                    // Bundle should be present here when the package is linked into an App.
                Bundle(for: BundleFinder.self).resourceURL, // Bundle should be present here when the package is linked into a framework.
                Bundle.main.bundleURL                       // For command-line tools.
            ].filter { $0 != nil }
            
            for candidate in candidates {
                let spmPackageName = "rjps-lib-uf"
                let spmProductName = "RJSLibUFStorage"
                let bundlePath = candidate?.appendingPathComponent("\(spmPackageName)_\(spmProductName).bundle")
                if let bundle = bundlePath.flatMap(Bundle.init(url:)),
                   let managedObjectModel = tryNSManagedObjectModelFrom(bundle: bundle) {
                    return managedObjectModel
                }
            }
            RJS_Logs.error("\(dbName) not found in any Bundle", tag: .rjsLib)
            return nil
        }()

        private static var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
            // The persistent store coordinator for the application. This implementation creates and returns a
            // coordinator, having added the store for the application to it.
            var someError: Error?
            let directoryUrls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            let directoryUrl = directoryUrls[directoryUrls.count-1]
            var coordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel!)
            let url = directoryUrl.appendingPathComponent("\(dbName).sqlite")
            do {
                try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
                return coordinator
            } catch {
                someError = error
            }
            RJS_Logs.error(someError, tag: .rjsLib)
            return NSPersistentStoreCoordinator()
        }()

        static var managedObjectContext: NSManagedObjectContext = {
            // Returns the managed object context for the application (which is already bound to the persistent store
            // coordinator for the application.) This property is optional since there are legitimate
            // error conditions that could cause the creation of the context to fail.
            var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
            managedObjectContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
            managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator
            return managedObjectContext
        }()

        public static func saveContext() {
            DispatchQueue.main.async {
                if managedObjectContext.hasChanges {
                    do {
                        try managedObjectContext.save()
                        RJS_Logs.message("DB record stored/updated/deleted", tag: .rjsLib)
                    } catch {
                        assertionFailure("\(error)")
                    }
                }
            }
        }
    }
}
