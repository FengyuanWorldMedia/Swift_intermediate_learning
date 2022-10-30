//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)

//: # 结构体初始化

import Foundation

//: ## 初始化的一般写法
struct Monster {
    var name: String
    var ranking: Int
    var desc: String?
}

// 初始化非Optional属性
let monster1 = Monster(name: "怪兽1号", ranking: 1)
// 初始化全部属性
let monster2 = Monster(name: "怪兽1号", ranking: 2, desc: "让英雄有去无回")
// 调用init方法， 初始化非Optional属性
let monster3 = Monster.init(name: "怪兽3号", ranking: 3)
// 调用init方法， 初始化全部属性
let monster4 = Monster.init(name: "怪兽4号", ranking: 4, desc: "小鬼-我当家")
// 调用init方法（省略结构体类型）， 初始化非Optional属性
let monster6: Monster = .init(name: "怪兽6号", ranking: 7)

struct MonsterDragon {
    var name: String?
    var ranking: Int?
    var desc: String?
}
let monster7 = MonsterDragon()
let monster9 = MonsterDragon(name: "怪兽Dragon", ranking: 5, desc: "难得一见的机会，哈哈")

//: ### 从以上的结构体初始化中，可以看出
//: ### 1.如果结构体中，有非Optional属性，则Swift提供所有属性的初始化方法（Memberwise initializers），包括Optional 属性也可被初始化。
//: ### 2.如果结构体中，全部是Optional属性，则Swift提供一个无参的初始化方法，同时也提供了对所有Optional属性的初始化方法（Memberwise initializers）


//: ## 给初始化方法分类
//: ### Memberwise initializers
// 参考：Monster 和 MonsterDragon 定义

//: ### Custom initializers
struct MonsterRobot {
    var name: String
    var ranking: Int
    var desc: String?
    
    init(name: String) {
        self.name = name
        self.ranking = 15
    }
}

// 值得注意的是，当我们添加自定义的初始化方法时， Swift将收回（Memberwise initializers 或 无参初始化方法）。
let monsterRobot = MonsterRobot(name: "机器人怪兽")

//: ### Designated initializers
// 指定的初始化器完全初始化引入的所有属性
// 参考：
//    Monster 和 MonsterDragon 定义
//    MonsterRobot 的 init(name: String)

//: ### Convenience initializers

struct MonsterWolf {
    var name: String
    var rangking: Int
    var desc: String?
    
    init(name: String) {
        self.name = name
        self.rangking = 15
    }
    
    init(name: String , desc: String?) { // 在结构体中，不需要  convenience 关键字
        self.init(name: name)
        self.desc = desc  // desc 的初始化，必须在 self.init 的后面。
    }
}

let monsterWolf1 = MonsterWolf(name: "怪兽狼人1号")
let monsterWolf2 = MonsterWolf(name: "怪兽狼人2号", desc: "在漆黑的夜里行动")


//: ### Required initializers
protocol InitAction {
    init()
}

struct MonsterEagle : InitAction {
    var name: String
    var ranking: Int
    var desc: String?
    
    init(name: String , desc: String?) {
        self.name = name
        self.ranking = 16
        self.desc = desc
    }
    
    init() {  // 在结构体中，不需要 required 关键字
        self.name = "怪兽老鹰"
        self.ranking = 16
    }
}

let monsterEagle1 = MonsterEagle()
let monsterEagle2 = MonsterEagle(name: "怪兽老鹰", desc: "苍穹之下，都在眼底")

//: ### Failable intializers

struct MonsterStoneMan {
    var name: String
    var ranking: Int
    var desc: String?
    
    init?(name: String , ranking: Int) {
        if ranking < 20 {
            return nil
        }
        self.name = name
        self.ranking = ranking
    }
}

let monsterStoneMan1 = MonsterStoneMan(name: "怪兽-石头人", ranking: 5)
let monsterStoneMan2 = MonsterStoneMan(name: "怪兽-石头人", ranking: 25)

//: ### Throwing initializers

struct MonsterFishMan {
    
    enum InitError: Error {
        case rankingError
        case namingError(String)
    }
    
    var name: String
    var ranking: Int
    var desc: String?
    
    init(name: String , ranking: Int) throws {
        if ranking < 10 {
            throw InitError.rankingError
        }
        if name.isEmpty || !name.lowercased().contains("fish") {
            throw InitError.namingError(name)
        }
        self.name = name
        self.ranking = ranking
    }
}

let monsterFishMan = try? MonsterFishMan(name: "怪兽雨人", ranking: 5)

do {
    let monsterFishMan2 = try MonsterFishMan(name: "怪兽-FISH MAN", ranking: 15)
    print(monsterFishMan2.ranking)
} catch MonsterFishMan.InitError.rankingError {
    print("级别错误")
} catch MonsterFishMan.InitError.namingError(let name) {
    print("名字错误, 名字:\(name)")
}

//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)
