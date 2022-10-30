//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)

//: # 格式化输出-print

import Foundation

//: # 1.print 输出信息到控制台
print("--No.1-------------------------------------------")
print("欢迎学习《Swift开发进阶教程》")
print("--No.2-------------------------------------------")
//: # 2.print 加入变量
let courseName = "Swift开发进阶教程"
print("欢迎学习《\(courseName)》")
print("--No.3-------------------------------------------")
//: # 3. print(_:separator:terminator:)
    //func print(
    //    _ items: Any...,
    //    separator: String = " ",
    //    terminator: String = "\n"
    //)
let nameOfWolves = ["狼人1号" , "狼人2号" , "狼人3号" , "狼人4号" ]
//: ## 3-1.省略 separator 和 terminator
print(nameOfWolves)
print("狼人1号" , "狼人2号" , "狼人3号" , "狼人4号")

//: ## 3-2.使用 separator 参数
print("狼人1号" , "狼人2号" , "狼人3号" , "狼人4号" , separator: "➡️")

//: ## 3-3.使用 terminator 参数
for name in nameOfWolves {
    print(name, separator: "➡️", terminator: "\n")
}
for name in nameOfWolves {
    print(name, terminator: "")
}

//: # 4. print(_:separator:terminator:to:)
    //func print<Target>(
    //    _ items: Any...,
    //    separator: String = " ",
    //    terminator: String = "\n",
    //    to output: inout Target
    //) where Target : TextOutputStream

//: # 4-1. 遵循 TextOutputStream 的内置类型
//: ## DefaultStringInterpolation,String,Substring, StringProtocol

print("")
print("--No.4-------------------------------------------")
var range = "My range: "
//: ### 注意⚠️： 换行符也被添加到 变量range 里了。
print(1...5, to: &range)
print(">>\(range)<<")

var separated = ""
print(1.0, 2.0, 3.0, 4.0, 5.0, separator: " ... ", terminator: "", to: &separated)
print(">>\(separated)<<")

var numbers = ""
for n in 1...5 {
    print(n, terminator: "", to: &numbers)
}
print(numbers)

//: # 4-2. 遵循 TextOutputStream
struct ASCIILogger: TextOutputStream {
    mutating func write(_ string: String) {
        let ascii = string.unicodeScalars.lazy.map { scalar in
            scalar == "\n" ? "\n" : scalar.escaped(asASCII: true)
        }
        print(ascii.joined(separator: ""), terminator: "")
    }
}
let s = "Hearts ♡ and Diamonds ♢ --丰源天下"
print(s)
// "Hearts ♡ and Diamonds ♢"

var asciiLogger = ASCIILogger()
print(s, to: &asciiLogger)
// Hearts \u{2661} and Diamonds \u{2662}


//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)
