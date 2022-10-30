//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)

//: # Optional是 枚举类型

//: ## 以下4种Optional类型变量 的声明方法是一样的，带有 ❓的 是Optional的语法糖。
var name: String? = nil

var nickName: Optional<String> = nil
var firstName = Optional.some("first name")
var lastName = Optional.init("last name")

print(name ?? "default name")
print(nickName ?? "default nickname")

print(lastName ?? "default lastName")

lastName = nil
switch lastName {
    case .none:
        print("default lastname")
    case .some(let wrapped):
        print(wrapped)
}

//: ## 模式匹配运算符 pattern-matching operator (`~=`)

//: ### 认识Swift中的 模式匹配运算符 `~=`
struct User {
    let firstName: String
    let secondName: String
    let age: Int
}

extension User {
    static func ~= (range: ClosedRange<Int>, user: User) -> Bool {
        return range.contains(user.age)
    }
    
//    static func ~= (user: User, range: ClosedRange<Int>,) -> Bool {
//        return range.contains(user.age)
//    }
}

let user = User(firstName: "王", secondName: "志友", age: 25)

switch user {
    case 21...30: print("王志友年龄在 21 - 30 岁之间")
    case 31...40: print("王志友年龄在 31 - 40 岁之间")
    default: break
}

//: ### Optional 模式匹配运算符 `~=` 的接口定义
//: ### public static func ~= (lhs: _OptionalNilComparisonType, rhs: Wrapped?) -> Bool

var companyName: String? = "丰源天下传媒"
switch companyName {
  case nil:
     print("No data stream is configured.")
  case let name?:
     print("Company name: \(name)")
}


//: ## 获取默认值的 ?? 运算符的定义， defalutValue 参数 是一个 自动闭包（autoclosure）。
//: ### public func ?? <T>(optional: T?, defaultValue: @autoclosure () throws -> T) rethrows -> T

lastName = nil
print(lastName ?? "default lastName")
lastName = "志友"
print(lastName ?? "default lastName")

//: ## Optional 中的 == 和 !=
//: ### public static func != (lhs: Optional<Wrapped>, rhs: Optional<Wrapped>) -> Bool
//: ### public static func == (lhs: Wrapped?, rhs: Wrapped?) -> Bool

name = nil
nickName = nil
if name == nickName {
    print("name == nickName")
}

name = nil
nickName = "志友"
if name != nickName {
    print("name != nickName")
}

//: ## Optional 这么好用，还可以自由扩展。
//: ### 实际上，如果您不是项目的架构师，完全没有必要进行扩展。Swift对Optional的语法糖，已经足够使用了。
extension Optional {
    func myDebugInfo() {
        switch self {
        case .none:
            print("No value")
        case .some(let wrapped):
            print("debug info, value:\(wrapped)")
        }
    }
}

nickName.myDebugInfo()

//: ## 如何看待Optional
//: ### 在具体的处理中，把它当成和Int，String等一样的基本数据类型进行处理。
//: ### 在程序设计时,如果有Optional数据类型参与的话，把它当成一个有一定功能的 枚举类型。

//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)
