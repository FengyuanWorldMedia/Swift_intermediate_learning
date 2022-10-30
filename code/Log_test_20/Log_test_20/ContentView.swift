//
//  ContentView.swift
//  Log_test_20
//
//  Created by 苏州丰源天下传媒 on 2022/10/1.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("《Swift进阶视频教程》")
            
            Button(action: {
                printLog()
            }, label: {
                Text("print 打印")
            }).padding(.top, 8)
            
            Button(action: {
                nslog()
            }, label: {
                Text("NSLog 打印")
            }).padding(.top, 8)
            
            Button(action: {
                os_log()
            }, label: {
                Text("os_log 打印")
            }).padding(.top, 8)
            
        }
        .padding()
    }
    
    func printLog() {
        print("-print-------------------")
        let logMessage = String(format: " log-test-print -- Welcome: %@, Course: %@", "No.11 Student", " Swift Advanced Video Tutorial ")
        print(logMessage)
        debugPrint(logMessage)
    }
    
    func nslog() {
        print("-NSLog-------------------")
        let logMessage = String(format: " log-test-print -- Welcome: %@, Course: %@", "No.22 Student", " Swift Advanced Video Tutorial ")
        LogUtil.logInfo(string: logMessage)
        LogUtil.logError(string: logMessage)
    }
    
    func os_log() {
        let logMessage = String(format: " log-test-print -- Welcome: %@, Course: %@", "No.33 Student", " Swift Advanced Video Tutorial ")
        print("-os_log-------------------")
        OSLogUtil.debug(logMessage)
        OSLogUtil.warning(logMessage)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
