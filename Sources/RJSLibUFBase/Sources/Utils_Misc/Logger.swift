//
//  Created by Ricardo P Santos on 2019.
//  Copyright © 2019 Ricardo P Santos. All rights reserved.
//

import Foundation
#if !os(macOS)
    import UIKit
#endif

// swiftlint:disable no_print

// MARK: - Logger (Public)

extension RJSLib {

    public struct Logger {
        private init() {}

        public enum Tag: String {
            case rjsLib
            case client
            
            var prettyName: String {
                switch self {
                case .rjsLib: return "RJSLibUF" // RJSLibUF logs id
                case .client: return "MyApp"    // Client app logs id
                }
            }
        }

        //private static var _logMessagesPrefix = "\(RJSLib.self).\(Logger.self)"
        private static var _debugCounter: Int = 0
        public static func cleanStoredLogs() {
            StorageUtils.deleteLogs()
        }

        
        public static func debug(_ message: Any?,
                                 tag: Logger.Tag,
                                 function: String = #function, file: String = #file, line: Int = #line) {
            guard message != nil else { return }
            let prefix = "# Type : Debug @ \(tag.prettyName)"
            private_print("\(prefix)\n\n\(message!)", function: function, file: file, line: line)
        }
        
        public static func info(_ message: Any?,
                                tag: Logger.Tag = .client,
                                function: String = #function, file: String = #file, line: Int = #line) {
            guard message != nil else { return }
            let prefix = "# Type : Info @ \(tag.prettyName)"
            private_print("\(prefix)\n\n\(message!)", function: function, file: file, line: line)
        }

        public static func warning(_ message: Any?,
                                   tag: Logger.Tag = .client,
                                   function: String = #function, file: String = #file, line: Int = #line) {
            guard message != nil else { return }
            let prefix = "# Type: Warning @ \(tag.prettyName)]"
            private_print("\(prefix)\n\n\(message!)", function: function, file: file, line: line)
        }

        public static func error(_ message: Any?,
                                 tag: Logger.Tag = .client,
                                 shouldCrash: Bool = false,
                                 function: String = #function, file: String = #file, line: Int = #line) {
            guard message != nil else { return }
            let prefix = "# Type : Error @ \(tag.prettyName)"
            private_print("\(prefix)\n\n\(message!)", function: function, file: file, line: line)
        }
        
        //
        // Log to console/terminal
        //
        
        private static func private_print(_ message: @autoclosure () -> String,
                                          function: String = #function,
                                          file: String = #file,
                                          line: Int = #line) {
            
            // When performed on physical device, NSLog statements appear in the device's console whereas
            // print only appears in the debugger console.
            
            _debugCounter     += 1
            let senderCodeId   = RJS_Utils.senderCodeId(function, file: file, line: line)
            let messageToPrint = message().trim
            let date           = Date.utcNow
            let logMessage     = """
            \n###################################################################
            # Log_\(_debugCounter) @ \(date)
            # \(senderCodeId)
            \(messageToPrint)
            """
            
            StorageUtils.appendToFile(logMessage)
            
            if !RJS_Utils.isSimulator {
                NSLog("%@\n", logMessage)
            } else {
                // NAO APAGAR O "Swift", senao a app pensa que é a esta mm funcao e entra em loop
                Swift.print(logMessage+"\n")
            }
        }
    }
}

// MARK: - Logger (Private)

fileprivate extension RJSLib.Logger {

    struct StorageUtils {

        fileprivate static var logFile: URL? {
             guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
             return documentsDirectory.appendingPathComponent("\(RJSLib.self).\(RJSLib.Logger.self).log")
        }

        static func deleteLogs() {
            guard let logFile = logFile else {  return }
            guard FileManager.default.isDeletableFile(atPath: logFile.path) else { return }
            try? FileManager.default.removeItem(atPath: logFile.path)
        }

        static func appendToFile(_ log: String) {
              guard let logFile = logFile else {  return }
              guard let data = ("\(log)\n").data(using: String.Encoding.utf8) else { return }
              if FileManager.default.fileExists(atPath: logFile.path) {
                  if let fileHandle = try? FileHandle(forWritingTo: logFile) {
                      fileHandle.seekToEndOfFile()
                      fileHandle.write(data)
                      fileHandle.closeFile()
                  }
              } else {
                  try? data.write(to: logFile, options: .atomicWrite)
              }
          }
    }
}
