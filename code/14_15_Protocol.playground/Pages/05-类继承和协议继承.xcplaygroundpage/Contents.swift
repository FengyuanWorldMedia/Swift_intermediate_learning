//: [目录](目录) - [Previous page](@previous) - [Next page](@next)

import Foundation

//: # 类继承和协议继承
//: ## 在狼人进化的过程中，相当一部分能力是从父类中继承，即使是从父类中继承，大概率也免不了被重写。

class MonsterWolfMan {
    var name: String
    var ranking: Int
    var desc: String?
    
    init(name: String) {
        self.name = name
        self.ranking = 15
        self.desc = "我是一只武装的怪兽-狼人"
    }
    
    func runAction() {
        print("\(self.name) run action")
    }
}

//: ## 子类重写了 runAction 和 新添加了一个方法 doWork.
//: ## 对于狼人军队来讲，这必将受到限制，因为只有 继承自狼人的 对象才能加入。
class MonsterWolfManSub: MonsterWolfMan {
    
    override func runAction() {
        print("\(self.name) run action")
    }
    
    func doWork(input: String) -> Bool {
        print("狼人接受了一个工作，输入是 字符，输出是 布尔")
        return true
    }
}

//: ## 继承的层级越多，我们越能感受到，功能在纵向上的 继承。
class MonsterWolfManSub_3: MonsterWolfManSub {
    
    override func runAction() {
        print("\(self.name) run action")
    }
    
    override func doWork(input: String) -> Bool {
        print("狼人接受了一个工作，输入是 字符，输出是 布尔")
        return true
    }
    func shoot(input: String) -> String {
        print("狼人兵器，输入是 字符，输出是 字符")
        return input
    }
}



//: # 狼人军队的扩展，不能由那个族群来组成，要求 只要满足 标准（协议的）都可以加入，且在功能上增强上 也是有 协议控制。
//: ## 分开的定义，有利于协议的定义，让狼人专职做指定的工作。 可以遵循一个协议 或则 多个协议的组合，且 类型不受限制（结构体，类或者枚举等）。这方便了【狼人军队】扩张。
//: ## 与继承的相比，协议更像是横向上的功能扩展。
protocol MonsterProtocolFirst {
    var name: String { get }
    var ranking: Int { get set}
    var desc: String? { get set}
    init(name: String)
    func runAction() -> Void
}

protocol MonsterProtocolSecond {
    associatedtype Input
    associatedtype Output
    func doWork(input: Input) -> Output
}

protocol MonsterProtocolThird {
    func shoot(input: String) -> String
}

//: # 协议的继承
//: ## 如果协议太多，造成了管理上的混乱，我们可以使用协议继承进行 增加功能。
//: ## 与类的继承相比，协议的继承 不包含实现，是更抽象的一层继承。
protocol MonsterProtocol_ver1 {
    var name: String { get }
    var ranking: Int { get set}
    var desc: String? { get set}
    init(name: String)
    func runAction() -> Void
}

protocol MonsterProtocol_ver2: MonsterProtocol_ver1 {
    associatedtype Input
    associatedtype Output
    func doWork(input: Input) -> Output
}

protocol MonsterProtocol_ver3 : MonsterProtocol_ver2 {
    func runAction() -> Void
}

//: # 协议的组合
//: ## 如果协议的继承，增加了协议间的关系，增加了管理难度，也可以使用组合的方式进行声明。
//: ## 对比 继承的方式，组合带来的多样性 将更多，且协议间的关系简单直接。
typealias MonsterProtocol_ver2_2 = MonsterProtocolFirst & MonsterProtocolSecond
typealias MonsterProtocol_ver3_3 = MonsterProtocolFirst & MonsterProtocolSecond & MonsterProtocolThird

//: [目录](目录) - [Previous page](@previous) - [Next page](@next)
