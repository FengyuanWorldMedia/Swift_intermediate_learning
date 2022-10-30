//
//  OSLogUtil.swift
//  Log_test_20
//
//  Created by 苏州丰源天下传媒 on 2022/10/1.
//

import Foundation
import os.log

struct OSLogUtil {
    enum LogLevel: String {
        case error = "ERROR"
        case warning = "WARNING"
        case debug = "DEBUG"
    }

    static func debug(_ info: String, level: LogLevel = .debug, file: String = #file, function: String = #function, line: Int = #line) {
        os_log("%@ %@:%d %@: %@", level.rawValue, (file as NSString).lastPathComponent, line, function, info)
    }

    static func warning(_ info: String, level: LogLevel = .warning , file: String = #file, function: String = #function, line: Int = #line) {
        os_log("%@ %@:%d %@: %@", level.rawValue, (file as NSString).lastPathComponent, line, function, info)
    }

    static func error(_ error: NSError, level: LogLevel = .error, file: String = #file, function: String = #function, line: Int = #line) {
        os_log("%@ %@:%d %@: %@",  level.rawValue, (file as NSString).lastPathComponent, line, function, "\(error)")
    }
}
