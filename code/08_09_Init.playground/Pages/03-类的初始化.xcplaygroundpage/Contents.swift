//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)


//: # 类的初始化

import Foundation

//: ## 初始化的一般写法
class Monster {
    var name: String
    var ranking: Int
    var desc: String?
    
    init() {
        self.name = "默认怪兽名称"
        self.ranking = 0
    }

    init(name: String , ranking: Int , desc: String? = nil) {
        self.name = name
        self.ranking = ranking
        self.desc = desc
    }
}

// 初始化非Optional属性
let monster1 = Monster(name: "怪兽1号", ranking: 1)
// 初始化全部属性
let monster2 = Monster(name: "怪兽1号", ranking: 2, desc: "让英雄有去无回")
// 调用init方法， 初始化非Optional属性
let monster3 = Monster.init(name: "怪兽3号", ranking: 3)
// 调用init方法， 初始化全部属性
let monster4 = Monster.init(name: "怪兽4号", ranking: 4, desc: "小鬼-我当家")
// 调用init方法（省略类的类型）， 初始化非Optional属性
let monster6: Monster = .init(name: "怪兽6号", ranking: 7)

class MonsterDragon1 {
    var name: String?
    var ranking: Int?
    var desc: String?
}
let monster7 = MonsterDragon1()

class MonsterDragon {
    var name: String?
    var ranking: Int?
    var desc: String?
    
    init() {
        
    }
    
    init(name: String , ranking: Int , desc: String? = nil) {
        self.name = name
        self.ranking = ranking
        self.desc = desc
    }

}

let monster8 = MonsterDragon()
let monster9 = MonsterDragon(name: "怪兽Dragon", ranking: 5, desc: "难得一见的机会，哈哈")

//: ### 从以上的类对象初始化中，可以看出
//: ### 1.如果类中含有非Optioanl属性，则 Swift 不类对象提供 默认初始化方法（Memberwise initializers 或 无参初始化方法）
//: ### 1.如果类中，全部都是Optional属性，则Swift提供 一个无参的 初始化方法
//: ### 2.如果类中，全部是是Optional属性，如果添加了一个 自定义的初始化方法，则 Swift会收回 无参的 初始化方法


//: ## 给初始化方法分类
//: ### Memberwise initializers （和结构体不同的是，需要自己定义）
// 参考：Monster 和 MonsterDragon 定义

//: ### Custom initializers
class MonsterRobot {
    var name: String
    var ranking: Int
    var desc: String?
    
    init(name: String) {
        self.name = name
        self.ranking = 15
    }
}

let monsterRobot = MonsterRobot(name: "机器人怪兽")

//: ### Designated initializers
// 指定的初始化器完全初始化引入的所有属性
// 参考：
//    Monster 和 MonsterDragon 定义
//    MonsterRobot 的 init(name: String)

//: ### Convenience initializers
//: ### Convenience initializers 可以调用 Convenience 初始化方法，但是最后都会调用 designated initializers
class MonsterWolf {
    var name: String
    var ranking: Int
    var desc: String?
    
    init(name: String) {
        self.name = name
        self.ranking = 15
    }
    
    convenience init(name: String , desc: String?) { // convenience 关键字的使用
        self.init(name: name)
        self.desc = desc                         // desc 的初始化，必须在 self.init 的后面
    }
    
    convenience init(name: String ,ranking: Int, desc: String?) { // convenience 初始化方法 调用 【convenience 初始化方法】
        self.init(name: name, desc: desc)
        self.ranking = ranking
    }
}

let monsterWolf1 = MonsterWolf(name: "怪兽狼人1号")
let monsterWolf2 = MonsterWolf(name: "怪兽狼人2号", desc: "在漆黑的夜里行动")


//: ### Required initializers
//protocol InitAction {
//    init()
//}

class MonsterEagle {
    var name: String
    var ranking: Int
    var desc: String?
    
    init(name: String , desc: String?) {
        self.name = name
        self.ranking = 16
        self.desc = desc
    }
    
    required init() {           //  required 关键字的使用; 同时意味着 MonsterEagle子类，必须实现 init（） 初始化方法
        self.name = "怪兽老鹰"
        self.ranking = 16
    }
}

let monsterEagle1 = MonsterEagle()
let monsterEagle2 = MonsterEagle(name: "怪兽老鹰", desc: "苍穹之下，都在眼底")

//: ### Failable intializers

class MonsterStoneMan {
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

class MonsterFishMan {
    
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


//: ### Designated initializers 不能定义在类扩展中
class MonsterRobotEx {
    var name: String?
    var ranking: Int?
    var desc: String?
}

extension MonsterRobotEx {
    convenience init(name: String) {
        self.init()
        self.name = name
    }
}
//
//
//let robot = MonsterRobotEx()
//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)

