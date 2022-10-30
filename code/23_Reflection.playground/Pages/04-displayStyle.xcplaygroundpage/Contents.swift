//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)

//: # displayStyle 类型判断

import Foundation


//: ## enum DisplayStyle
    //case `class`
    //case collection
    //case dictionary
    //case `enum`
    //case optional
    //case set
    //case `struct`
    //case tuple


class OptionalMirror {
    
    static func isOptional(any: Any) -> Bool {
        guard let style = Mirror(reflecting: any).displayStyle, style == .optional else {
            return false
        }
        return true
    }
    
    static func unwrap(any: Any) -> Any {
        let mi = Mirror(reflecting: any)
        if mi.displayStyle != .optional {
            return any
        }
        if mi.children.count == 0 {
            return NSNull()
        }
        let (some, someValue) = mi.children.first!
        print(some!)
        return someValue
    }
}

// print(OptionalMirror.isOptional(any: "苏州丰源天下传媒"))

let val : String? = "苏州丰源天下传媒"
print(OptionalMirror.isOptional(any: val as Any))
print(OptionalMirror.unwrap(any: val as Any))




//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)


