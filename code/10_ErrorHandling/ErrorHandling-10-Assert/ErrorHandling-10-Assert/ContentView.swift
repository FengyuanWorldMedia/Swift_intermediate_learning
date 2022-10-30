//
//  ContentView.swift
//  ErrorHandling-10-Assert
//
//  Created by 丰源天下 on 2022/8/13.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Swift开发进阶教程-异常处理-断言")
            .padding()
            .onAppear() {
                let assertTest = AssertCheckClass()
                assertTest.testHandler()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
