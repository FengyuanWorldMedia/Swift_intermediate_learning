//
//  LogUtil.swift
//  Log_test_20
//
//  Created by 苏州丰源天下传媒 on 2022/10/1.
//

import Foundation

public class LogUtil {

   private static let patternError = "[MyApp] ERROR %@"
   private static let patternInfo  = "[MyApp] INFO %@"

   public class func logInfo(string: String) {
       NSLog(patternInfo, string)
   }

   public class func logError(string: String) {
       NSLog(patternError, string)
   }
}
 
  
