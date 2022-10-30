//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)

//: # superclassMirror 获取父类定义

import Foundation

//: ## 父类 Monster
class Monster {
    var name: String
    var ranking: Int
    var desc: String?
    
    init(name: String, ranking: Int, desc: String?) {
        self.name = name
        self.ranking = ranking
        self.desc = desc
    }
    
    func fight() {
        print("fight")
    }
}

//: ## 子类 WolfMan
class WolfMan: Monster {
    var no: String
    
    init(name: String, ranking: Int, desc: String?, no: String) {
        self.no = no
        super.init(name: name, ranking: ranking, desc: desc)
    }
}

let monster = Monster(name: "狼人1号", ranking: 10, desc: "最棒的一个士兵")
Mirror(reflecting: monster).children.forEach { child in
    print("字段 '\(child.label ?? "")' 值 '\(child.value)'")
}

print("--------------------------------")
let wolfMan = WolfMan(name: "狼人1号", ranking: 10, desc: "最棒的一个士兵", no: "123456")
dump(wolfMan)

//: ## 获取子类字段定义的值
Mirror(reflecting: wolfMan).children.forEach { child in
    print("子类对象字段 '\(child.label ?? "")' 值 '\(child.value)'")
}

//: ## 通过superclassMirror 获取父类字段定义的值
let parentMirror = Mirror(reflecting: wolfMan).superclassMirror
parentMirror?.children.forEach { child in
    print("父类 字段 '\(child.label ?? "")' 值 '\(child.value)'")
}
//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)
