
//: [回到目录](目录) - [Previous page](@previous)

//: # 一个好汉三个帮

import Foundation

// 竞争协议
protocol Competitive {
    func compete()
}

final class Monster: Competitive {
    var name: String
    var ranking: Int
    var desc: String?
    
    init(name: String, ranking: Int, desc: String?) {
        self.name = name
        self.ranking = ranking
        self.desc = desc
    }
    
    func compete() {
        print("\(name) 参与 竞争.")
    }
    
    var follower1: Monster? // 部下1
    var follower2: Monster? // 部下2
    var follower3: Monster? // 部下3
}

class MonsterArmy {
    
    /// 调用 Monster的部下的compete 方法。
    /// - Parameters:
    ///   - monster: 野兽
    ///   - type: 野兽类型
    ///   - recursiveFlag: 是否递归 调用其 部下的compete 方法
    ///   - closure: 处理 野兽对象 闭包（想定在闭包内执行compete 方法 ）
    static func callCompete<T>(of monster: Any,
                               matchingType type: T.Type = T.self,
                               recursiveFlag: Bool = false,
                               using closure: (T) -> Void) {
        let mirror = Mirror(reflecting: monster)
        for child in mirror.children {
            if let subMonster = child.value as? T {
                closure(subMonster)
                // 要不要递归调用
                if recursiveFlag {
                    callCompete(of: subMonster, recursiveFlag: true, using: closure)
                }
            }
        }
    }
}


let monster = Monster(name: "狼人0号", ranking: 10, desc: "最棒的一个士兵")

let monster1 = Monster(name: "狼人1号", ranking: 10, desc: "最棒的一个士兵")
let monster11 = Monster(name: "狼人11号", ranking: 8, desc: "最棒的一个士兵")
let monster12 = Monster(name: "狼人12号", ranking: 9, desc: "最棒的一个士兵")
monster1.follower1 = monster11
monster1.follower2 = monster12

let monster2 = Monster(name: "狼人2号", ranking: 10, desc: "最棒的一个士兵")
let monster21 = Monster(name: "狼人21号", ranking: 8, desc: "最棒的一个士兵")
let monster22 = Monster(name: "狼人22号", ranking: 9, desc: "最棒的一个士兵")
let monster23 = Monster(name: "狼人23号", ranking: 9, desc: "最棒的一个士兵")
monster2.follower1 = monster21
monster2.follower2 = monster22
monster2.follower3 = monster23

monster.follower1 = monster1
monster.follower2 = monster2

//: ## 写法1: 通过 matchingType 类型指定，让Swift 进行 范型的推断
MonsterArmy.callCompete(of: monster, matchingType: Competitive.self, recursiveFlag: true) { monster in
    monster.compete()
}

print("----------------------------------------------")

//: ## 写法2: 通过 闭包的参数类型指定，让Swift 进行 范型的推断
MonsterArmy.callCompete(of: monster) { (monster: Competitive) in
    monster.compete()
}

//: [回到目录](目录) - [Previous page](@previous)
