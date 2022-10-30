//: [回到目录](目录) - [Previous page](@previous)

//: # dump -- 调试使用(方便查看对象信息-结构化显示)
// https://developer.apple.com/documentation/swift/dump(_:name:indent:maxdepth:maxitems:)
// https://developer.apple.com/documentation/swift/dump(_:to:name:indent:maxdepth:maxitems:)

import Foundation

//: ## 结构体 dump
struct WolfMan {
    let name: String
    let magicPoint: Int
    let descripton: String
}

let wolfMan: WolfMan = WolfMan(name: "狼人1号", magicPoint: 62, descripton: "正在执行任务。。")
print(wolfMan)
dump(wolfMan)
//▿ __lldb_expr_7.WolfMan
//  - name: "狼人1号"
//  - magicPoint: 62
//  - descripton: "正在执行任务。。"

print("--dump----------------------------------------------------------")
//: ## 类对象 dump

class SecurityInfo {
    let signMethod = "md5"
    let password = "my password"
}

class WolfManClass {
    let name: String
    let magicPoint: Int
    let descripton: String
    let securityInfo = SecurityInfo()

    init(name: String, magicPoint: Int, descripton: String) {
        self.name = name
        self.magicPoint = magicPoint
        self.descripton = descripton
    }
}

let wolfMan2: WolfManClass = WolfManClass(name: "狼人2号", magicPoint: 100, descripton: "正在执行任务。。")
print(wolfMan2)
/// __lldb_expr_3.WolfManClass

dump(wolfMan2, name: "狼人2号")
//__lldb_expr_9.WolfManClass
//▿ __lldb_expr_9.WolfManClass #0
//  - name: "狼人2号"
//  - magicPoint: 100
//  - descripton: "正在执行任务。。"
//  ▿ securityInfo: __lldb_expr_9.SecurityInfo #1
//    - signMethod: "md5"
//    - password: "my password"

print("--dump to----------------------------------------------------------")
//: ## 类对象 dump to
var debugInfoString = ""
dump(wolfMan2, to: &debugInfoString, name: "狼人2号")
print(debugInfoString)

//: [回到目录](目录) - [Previous page](@previous)
