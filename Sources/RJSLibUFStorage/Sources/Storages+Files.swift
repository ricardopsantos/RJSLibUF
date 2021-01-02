//
//  Created by Ricardo P Santos on 2019.
//  Copyright © 2019 Ricardo P Santos. All rights reserved.
//

import Foundation
#if !os(macOS)
import UIKit
#endif
//
import RJSLibUFBase

public extension RJSLib.Storages {
    private init() {}
    
    struct Files {
        private init() {}
        
        public enum Folder: Int { case documents, temp }
        
        public static func folderFrom(_ folder: Folder) -> String {
            switch folder {
            case .documents: return documentsDirectory
            case .temp: return tempDirectory
            }
        }
        
        public static var documentsDirectory: String = {
            let dir: FileManager.SearchPathDirectory = RJS_Utils.onSPMInstall ? .cachesDirectory : .documentDirectory
            if let documentsDirectory = NSSearchPathForDirectoriesInDomains(dir, .userDomainMask, true).first {
                return documentsDirectory as String
            }
            return tempDirectory
        }()

        public static var tempDirectory: String = {
            return NSTemporaryDirectory() as String
        }()
        
        #if !os(macOS)
        public static func imageWith(name: String, folder: Folder = .documents) -> UIImage? {
            guard !name.isEmpty else { return nil }
            let destinyFolder = self.folderFrom(folder)
            var path          = "\(destinyFolder)/\(name)"
            path              = path.replacingOccurrences(of: "\\", with: "/")
            if let result   = UIImage(contentsOfFile: path) {
                return result
            }
            return nil
        }
        #endif
        
        #if !os(macOS)
        public static func saveImageWith(name: String, folder: Folder = .documents, image: UIImage) -> Bool {
            guard !name.isEmpty else { return false }
            
            let destinyFolder = self.folderFrom(folder)
            var path          = "\(destinyFolder)/\(name)"
            path              = path.replacingOccurrences(of: "\\", with: "/")

            var success = false
            if let data = image.pngData() {
                success = (try? data.write(to: URL(fileURLWithPath: path), options: [.atomic])) != nil
            }
            return success
        }
        #endif
        
        public static func fileNamesInFolder(_ folder: Folder=Folder.documents) -> [String] {
            let destinyFolder = self.folderFrom(folder)
            
            let fileManager = FileManager.default
            do {
                var filePaths = try fileManager.contentsOfDirectory(atPath: destinyFolder as String)
                if filePaths.count>0 && filePaths[0].hasPrefix("com.apple") {
                    filePaths.remove(at: 0)
                }
                return filePaths
            } catch {
                RJS_Logs.error("\(error)")
            }
            return []
        }
        
        public static func clearFolder(_ folder: Folder = .documents) {
            let destinyFolder = self.folderFrom(folder)
            let filePaths = fileNamesInFolder(folder)
            for filePath in filePaths {
                _ = deleteFile("\(destinyFolder)/\(filePath)")
            }
        }

        @discardableResult
        public static func deleteFile(_ fileFullPath: String) -> Bool {
            do {
                try FileManager.default.removeItem(atPath: fileFullPath)
                return true
            } catch {
                return false
            }
        }
        
        public static func deleteFile(_ fileName: String, folder: Folder) -> Bool {
            let destinyFolder = self.folderFrom(folder)
            var path          = "\(destinyFolder)/\(fileName)"
            path              = path.replacingOccurrences(of: "\\", with: "/")
            return deleteFile(path)
        }
        
        @discardableResult public static func appendToFile(_ fileName: String, toAppend: String, folder: Folder = .documents, overWrite: Bool) -> Bool {
            let destinyFolder = self.folderFrom(folder)
            var path          = "\(destinyFolder)/\(fileName)"
            path              = path.replacingOccurrences(of: "\\", with: "/")
            if overWrite {
                _ = deleteFile(path)
                return FileManager.default.createFile(atPath: path, contents: Data(toAppend.utf8), attributes: nil)
            } else {
                let finalContent = readContentOfFile(fileName, folder: folder) + "\(toAppend)"
                return FileManager.default.createFile(atPath: path, contents: Data("\(finalContent)".utf8), attributes: nil)
            }
        }
        
        @discardableResult public static func readContentOfFile(_ fileName: String, folder: Folder=Folder.documents) -> String {
            let destinyFolder = self.folderFrom(folder)
            var path          = "\(destinyFolder)/\(fileName)"
            path              = path.replacingOccurrences(of: "\\", with: "/")
            if let data = FileManager.default.contents(atPath: path) {
                return String(decoding: data, as: UTF8.self)
            }
            return ""
        }
        
        @discardableResult public static func readContentOfFileInBundle(_ fileName: String) -> String? {
            if let filepath = Bundle.main.path(forResource: fileName, ofType: "") {
                do {
                    return try String(contentsOfFile: filepath)
                } catch {
                    return nil
                }
            } else {
                return nil
            }
        }
        
    }
}
