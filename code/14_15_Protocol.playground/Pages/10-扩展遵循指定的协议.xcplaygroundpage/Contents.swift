//: [目录](目录) - [Previous page](@previous)

import Foundation

//: # 在结构体或类的扩展中，遵循指定的协议

protocol MonsterProtocol {
    var name: String { get }
    var ranking: Int { get set}
    var desc: String? { get set}
    init(name: String)
    func runAction() -> Void
}

class MonsterBearMan {
    
    var weight: Int = 0
    var name: String
    var ranking: Int
    var desc: String?
    
    required init(name: String) {
        self.name = name
        self.ranking = 15
        self.desc = "我是的怪兽-熊1号"
    }
    
    func divingAction() {
        print("MonsterBearMan --> divingAction ")
    }
}

//: ## 在类的扩展中，使其遵循指定的协议。
extension MonsterBearMan : MonsterProtocol {
    func runAction() {
        print("MonsterBearMan: MonsterProtocol --> runAction ")
    }
}


let bearMan: Any = MonsterBearMan(name: "我是一个 魔兽大熊🐻")

type(of: bearMan)

if let wolfMan = bearMan as? MonsterProtocol {
    wolfMan.runAction()
} else {
    print("Not a wolfman")
}


//: [目录](目录) - [Previous page](@previous) 
