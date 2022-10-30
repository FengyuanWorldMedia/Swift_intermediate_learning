//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)

//: # 格式化输出-debugPrint

import Foundation

//: # 1.debugPrint 输出信息到控制台
debugPrint("--No.1-------------------------------------------")
debugPrint("欢迎学习《Swift开发进阶教程》")
debugPrint("--No.2-------------------------------------------")
//: # 2.debugPrint 加入变量
let courseName = "Swift开发进阶教程"
debugPrint("欢迎学习《\(courseName)》")
debugPrint("--No.3-------------------------------------------")
//: # 3. debugPrint(_:separator:terminator:)
    //func debugPrint(
    //    _ items: Any...,
    //    separator: String = " ",
    //    terminator: String = "\n"
    //)
let nameOfWolves = ["狼人1号" , "狼人2号" , "狼人3号" , "狼人4号" ]
//: ## 3-1.省略 separator 和 terminator
debugPrint(nameOfWolves)
debugPrint("狼人1号" , "狼人2号" , "狼人3号" , "狼人4号")

//: ## 3-2.使用 separator 参数
debugPrint("狼人1号" , "狼人2号" , "狼人3号" , "狼人4号" , separator: "➡️")

//: ## 3-3.使用 terminator 参数
for name in nameOfWolves {
    debugPrint(name, separator: "➡️", terminator: "\n")
}
for name in nameOfWolves {
    debugPrint(name, terminator: "")
}

//: # 4. debugPrint(_:separator:terminator:to:)
    //func debugPrint<Target>(
    //    _ items: Any...,
    //    separator: String = " ",
    //    terminator: String = "\n",
    //    to output: inout Target
    //) where Target : TextOutputStream

//: # 4-1. 遵循 TextOutputStream 的内置类型
//: ## DefaultStringInterpolation,String,Substring, StringProtocol

debugPrint("")
debugPrint("--No.4-------------------------------------------")
var range = "My range: "
//: ### 注意⚠️： 换行符也被添加到 变量range 里了。
debugPrint(1...5, to: &range)
debugPrint(range)

var separated = ""
debugPrint(1.0, 2.0, 3.0, 4.0, 5.0, separator: " ... ", terminator: "", to: &separated)
debugPrint(">>\(separated)<<")

var numbers = ""
for n in 1...5 {
    debugPrint(n, terminator: "", to: &numbers)
}
debugPrint(numbers)

//: # 4-2. 遵循 TextOutputStream
struct ASCIILogger: TextOutputStream {
    mutating func write(_ string: String) {
        let ascii = string.unicodeScalars.lazy.map { scalar in
            scalar == "\n" ? "\n" : scalar.escaped(asASCII: true)
        }
        debugPrint(ascii.joined(separator: ""), terminator: "")
    }
}
let s = "Hearts ♡ and Diamonds ♢ --丰源天下"
debugPrint(s)
// "Hearts ♡ and Diamonds ♢"

var asciiLogger = ASCIILogger()
debugPrint(s, to: &asciiLogger)
// Hearts \u{2661} and Diamonds \u{2662}

print("\n--No.5-------------------------------------------")
//: # 5.debugPrint 和 print 的不同。
//: ## debugPrint是为了调试，加入了更多的信息。

print(1...5)
// "1...5"

debugPrint(1...5)
// "CountableClosedRange(1...5)"


//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)
