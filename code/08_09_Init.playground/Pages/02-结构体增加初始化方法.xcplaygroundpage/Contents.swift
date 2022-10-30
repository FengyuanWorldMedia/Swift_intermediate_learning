//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)

//: # 为结构体增加初始化方法

import Foundation

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
let monsterRobot1 = MonsterRobot(name: "机器人怪兽")

struct MonsterRobotEx {
    var name: String
    var ranking: Int
    var desc: String?
}

//: ## 在扩展中增加初始化方法，可以保留Swift提供的 初始化方法
extension MonsterRobotEx {
    init(name: String) {
        self.name = name
        self.ranking = 15
    }
}

let monsterRobot2 = MonsterRobotEx(name: "机器人怪兽1号")

let monsterRobot3 = MonsterRobotEx(name: "机器人怪兽2号", ranking: 20)

var monsterRobot4 = MonsterRobotEx(name: "机器人怪兽3号", ranking: 20, desc: "地球上没有对手")
    

//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)
