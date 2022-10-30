//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)

//: # 对各种类型数据进行反射

import Foundation
 
print("---对类对象进行反射---------------------------------------")
final class Monster {
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
 
let monster = Monster(name: "狼人1号", ranking: 10, desc: "最棒的一个士兵")

Mirror(reflecting: monster).children.forEach { child in
    print("字段 '\(child.label ?? "")' 值 '\(child.value)'")
}

print("---对元组进行反射---------------------------------------")

let tuple = (name: "狼人2号", "最棒的一个士兵 2 号")
Mirror(reflecting: tuple).children.forEach { child in
    print("字段  '\(child.label ?? "")' 值 '\(child.value)'")
}

print("---对枚举进行反射---------------------------------------")
enum FightState {
    case fighting(Date)
    case fighted
}

let fighting = FightState.fighting(Date())
Mirror(reflecting: fighting).children.forEach { child in
    print("字段  '\(child.label ?? "")' 值 '\(child.value)'")
}

let fighted = FightState.fighted
Mirror(reflecting: fighted).children.forEach { child in
    print("字段  '\(child.label ?? "")' 值 '\(child.value)'") // 没有输出
}

print("---对数组进行反射---------------------------------------")
let array = ["狼人1号", "狼人2号", "狼人3号"]
Mirror(reflecting: array).children.forEach { child in
    print("字段 '\(child.label ?? "")' 值 '\(child.value)'")
}
// 字段 '' 值 '狼人1号'
// 字段 '' 值 '狼人2号'
// 字段 '' 值 '狼人3号'

print("---对字典进行反射---------------------------------------")
let dict = ["战士1":"狼人1号", "战士2":"狼人2号", "战士3":"狼人3号"]
Mirror(reflecting: array).children.forEach { child in
    print("字段 '\(child.label ?? "")' 值 '\(child.value)'")
}
// 字段 '' 值 '狼人1号'
// 字段 '' 值 '狼人2号'
// 字段 '' 值 '狼人3号'


//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)
