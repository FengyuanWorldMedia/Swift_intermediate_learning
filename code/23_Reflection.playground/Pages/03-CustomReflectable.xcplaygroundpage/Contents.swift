//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)

//: # CustomReflectable
//: ## 对 Mirror#children 进行自定义

import Foundation

struct Monster {
    var name: String
    var ranking: Int
    var desc: String?
    
    func fight() {
        print("fight")
    }
}

extension Monster: CustomReflectable {
    public var customMirror: Mirror {
        return Mirror(self, children: ["details": " name:\(name), ranking:\(ranking), desc: \(desc ?? "")"])
    }
}

let monster = Monster(name: "狼人1号", ranking: 10, desc: "最棒的一个士兵")
let mirror = Mirror(reflecting: monster)

mirror.children.forEach { child in
    print("字段 '\(child.label ?? "")' 值 '\(child.value)'")
}

//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)
