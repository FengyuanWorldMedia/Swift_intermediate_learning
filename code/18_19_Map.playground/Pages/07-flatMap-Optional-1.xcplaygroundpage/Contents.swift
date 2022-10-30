//: [目录](目录) - [Previous page](@previous) - [Next page](@next)

import Foundation

//: # flatMap对Optional操作

//: ## 在之前的学习，我们知道Optional是一个 带有范型Wrapped 的一个 枚举类型。
let magicPoint: Int? = Optional.init(100)
print(type(of: magicPoint)) /// Optional<Int>

//: ## 如果 Wrapped 也是一个 Int?， 就出现了 Optional 嵌套。
//: ## 获取“真实的数据”，将变得 困难。
let magicPoint2: Optional<Int?> = Optional.init(magicPoint)
print(type(of: magicPoint2)) /// Optional<Optional<Int>>

//: ## 如此下去，构造更深的 嵌套 Optional 类型。
let magicPoint3 = Optional.init(magicPoint2)
print(type(of: magicPoint3)) /// Optional<Optional<Optional<Int>>>


//: ## 获取“真实的数据”
//: ## 随着层级的加深，获取业务数据也变得更困难
if let mp2 = magicPoint3, let mp1 = mp2, let mp = mp1 {
    print(mp)           // 100
    print(type(of: mp))  // Int
}


extension Mirror {
    
    static func isOptional(any: Any) -> Bool {
        guard let style = Mirror(reflecting: any).displayStyle,
            style == .optional else { return false }
        return true
    }
    
    static func unwrap(any: Any) -> Any {
        let mi = Mirror(reflecting: any)
        if mi.displayStyle != .optional {
            return any
        }
        if mi.children.count == 0 { return NSNull() }
        let (_, some) = mi.children.first!
        return some
    }
}

Mirror.isOptional(any: "苏州丰源天下传媒")

print("--------------------------------------------------")

//: ## 注意⚠️ as Optional 语句会把 数据加入到 Optional 的“盒子”中。
if let a = 5 as Optional<Int>  {
    print(type(of: a))
}

print("--------------------------------------------------")
//: ## 递归实现 获取“真实的数据”
func getRealValue<T>(v: T) {
    if Mirror.isOptional(any: v) {
        print("Optional type")
        getRealValue(v: Mirror.unwrap(any: v))
    } else {
        print("Real value:\(v)")
    }
}

//: ## 调用递归方法 getRealValue
getRealValue(v: magicPoint3)

//: ## 幸运的是: Optional#flatMap 为我们搞定了😄
//: ### public func flatMap<U>(_ transform: (Wrapped) throws -> U?) rethrows -> U?
magicPoint3?.flatMap { $0 }

let result = magicPoint3?.flatMap { wrapped in
    print(type(of: wrapped))
    print(wrapped)
    return wrapped
}

print(result)
//: [目录](目录) - [Previous page](@previous) - [Next page](@next)
