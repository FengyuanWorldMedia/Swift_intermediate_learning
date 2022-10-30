//: [目录](目录) - [Previous page](@previous) - [Next page](@next)

import Foundation

//: # 协议的交集

//: ## 魔兽力量协议
protocol MonsterPowerProtocol {
    var name: String { get set }
    func power() -> Void
}

extension MonsterPowerProtocol {
    func power() {
        print("MonsterPowerProtocol --> power")
    }
}

//: ## 魔兽飞行协议
protocol MonsterFlyProtocol {
    func fly() -> Void
}

extension MonsterFlyProtocol {
    func fly() {
        print("MonsterFlyProtocol --> fly")
    }
}

//: ## 这里的扩展，非常重要。
//: ## 协议限定了 只有遵循了 MonsterPowerProtocol ，才能 使用 MonsterFlyProtocol 中指挥军队的 能力。
//: ## 实际上，扩展 MonsterPowerProtocol 也是可以的。(但是，意义就发生了变化。)
extension MonsterFlyProtocol where Self: MonsterPowerProtocol {
    func commandWolfArmy() {
        print("狼人: \(self.name), 拥有了 指挥狼人军队的权利。")
    }
}

//: ## 显然 MonsterWolfMan_1的对象 不能指挥狼人军队。
class MonsterWolfMan_1: MonsterPowerProtocol {
    var name: String
    var ranking: Int
    var desc: String?
    
    required init(name: String) {
        self.name = name
        self.ranking = 15
        self.desc = "我是一只有【力量】的怪兽-狼人"
    }
}

var wolfman1 = MonsterWolfMan_1(name: "狼人1号")
print(wolfman1.name)
print(wolfman1.ranking)
print(wolfman1.desc ?? "No description")

wolfman1.power()
// Value of type 'MonsterWolfMan_1' has no member 'commandWolfArmy'
// wolfman1.commandWolfArmy()


//: ## 魔兽遵循了 【力量和飞行】协议。同时，也拥有了 【指挥狼人军队】的能力。
class MonsterWolfMan: MonsterPowerProtocol, MonsterFlyProtocol {
    var name: String
    var ranking: Int
    var desc: String?
    
    required init(name: String) {
        self.name = name
        self.ranking = 15
        self.desc = "我是一只有【力量】且可以【飞行】的怪兽-狼人"
    }
}

var wolfman = MonsterWolfMan(name: "狼人1号")
print(wolfman.name)
print(wolfman.ranking)
print(wolfman.desc ?? "No description")

wolfman.power()
wolfman.fly()

//: ## 【指挥狼人军队】
wolfman.commandWolfArmy()


//: [目录](目录) - [Previous page](@previous) - [Next page](@next)
