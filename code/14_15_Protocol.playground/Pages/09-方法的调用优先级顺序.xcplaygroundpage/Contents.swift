//: [目录](目录) - [Previous page](@previous) - [Next page](@next)

import Foundation

//: # 方法的调用优先级顺序
//: ## 优先顺序：
//: ### 对象方法 > 【父类方法： 如果有继承情况】 > 对象遵循【协议】的默认方法实现 > 对象遵循【协议】的【父协议】的默认方法实现
//: ### 原则： 越是【逻辑上靠近实体对象】的方法，越是优先被调用。
//: ### 由这个原则，可以根据方法的【影响范围】，在合适的地方 进行 协议方法默认实现，以及在 合适的地方进行覆盖。
//: ### 方法覆盖的时候，只能是 实体对象覆盖 协议的默认实现； 协议不能覆盖 实体对象的方法（对象优先级高！！）。

protocol MonsterProtocol {
    var name: String { get }
    var ranking: Int { get set}
    var desc: String? { get set}
    init(name: String)
    func runAction() -> Void
}

extension MonsterProtocol {
    func runAction() {
        print("MonsterProtocol --> runAction")
    }
}

//: ## 声明 MonsterProtocol_Sub 协议，继承 协议 MonsterProtocol。
protocol MonsterProtocol_Sub : MonsterProtocol {
    
}

extension MonsterProtocol_Sub {
    func runAction() {
        print("MonsterProtocol_Sub --> runAction")
    }
}

//: # 如果类中没有定义runAction 方法的话，将会优先使用 MonsterProtocol 扩展中的 runAction方法。
class MonsterWolfMan: MonsterProtocol {
    var name: String
    var ranking: Int
    var desc: String?
    
    required init(name: String) {
        self.name = name
        self.ranking = 15
        self.desc = "我是的怪兽-狼人1号"
    }
    
    func runAction() {
        print("MonsterWolfMan --> runAction ")
    }
}

//: ## 如果类中没有定义runAction 方法的话，将会优先使用 MonsterProtocol_Sub 扩展中的 runAction方法。
//: ## 如果MonsterProtocol_Sub，扩展中没有方法的情况，将使用 MonsterProtocol 扩展中的方法。
class MonsterWolfManSub: MonsterProtocol_Sub {
    var name: String
    var ranking: Int
    var desc: String?
    
    required init(name: String) {
        self.name = name
        self.ranking = 15
        self.desc = "我是的怪兽-狼人1号"
    }
    
    func runAction() {
        print("MonsterWolfManSub --> runAction ")
    }
}

let subWolfMan = MonsterWolfManSub(name: "狼人1号")

subWolfMan.runAction()




//: [目录](目录) - [Previous page](@previous) - [Next page](@next)
