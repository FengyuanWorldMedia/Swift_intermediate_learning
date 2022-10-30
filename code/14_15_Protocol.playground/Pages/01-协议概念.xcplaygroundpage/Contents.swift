//: [目录](目录) - [Previous page](@previous) - [Next page](@next)

import Foundation

//: # 协议概念
//: ## 协议定义了适合特定任务或功能的方法、属性和其他需求的蓝图。
//: ## 然后，类、结构或枚举可以采用该协议，以提供这些需求的实际实现。任何满足协议要求的类型都称为符合该协议。

//: ## 根据协议的定义可以知道，当我们要描述功能蓝图时，也不管他的实现类型。我们应该想到 使用协议。
//: ## 协议可以看成接口或者类型。

// 定义狼人协议
protocol MonsterProtocol {
    var name: String { get }
    var ranking: Int { get set}
    var desc: String? { get set}
    init(name: String)
    func runAction() -> Void
}


// 遵守了（实现了）狼人协议
struct MonsterWolf_1 : MonsterProtocol {
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

// 遵守了（实现了）狼人协议
struct MonsterWolf_2 : MonsterProtocol {
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

//: ## 如果建立一个狼人组成的【怪兽👾军队】，很容易就想到如下定义。
struct MonsterArmy<T: MonsterProtocol> {
    
    var monsters: Array<T> = Array()
    
    init() {}
   
    init(monsters: Array<T>) {
        self.monsters = monsters
    }
    
    mutating func addMonster(monster: T) {
        self.monsters.append(monster)
    }
}

//: # 如果单纯的从使用来看，以上的例子简单。容易理解，符合范型的使用定义。
//: # 不过... 讨论也就此展开。

//: ## 从之前的学习，我们可以从 【怪兽👾军队】可以看出，一旦军队对象产生后，狼人怪兽只能是一种。
//: ## 这里无法将2种怪兽同时加入【怪兽👾军队】，在编译时就报错。如我们学过的一样：范型的类型，是在编译时(compile-time)就得确定。
//let monsters : [Any] = [ MonsterWolf_1(name: "狼人1号") , MonsterWolf_2(name: "狼人2号")]
//let monsterArmy = MonsterArmy<MonsterWolf_1>()

//: ## 为了满足，【怪兽👾军队】可以收编各种【🐺狼人】，我们就得除去编译时(compile-time)类型已知的约束。
//: ## 协议：如果作为类型进行使用的话，运行时Run-Time才能确定它的真实类型。


//: ## 升级版【怪兽👾军队】，只要是遵守MonsterProtocol协议的，都可以加入军队。
struct MonsterArmyEx {
    
    var monsters: Array<MonsterProtocol> = []
    
    init() {}
   
    init(monsters: Array<MonsterProtocol>) {
        self.monsters = monsters
    }
    
    mutating func addMonster(monster: MonsterProtocol) {
        self.monsters.append(monster)
    }
}

// 使用类定义的狼人
class MonsterWolf_3 : MonsterProtocol {
    var name: String
    var ranking: Int
    var desc: String?
    
    required init(name: String) {
        self.name = name
        self.ranking = 15
        self.desc = "我是一只武装的怪兽-狼人"
    }
    
    func runAction() {
        print("\(self.name) run action")
    }
}

//: ## 可以容纳【各种🐺狼人】
let monsters : [MonsterProtocol] = [ MonsterWolf_1(name: "狼人1号") , MonsterWolf_2(name: "狼人2号") , MonsterWolf_3(name: "狼人3号")]
var monsterArmyEx = MonsterArmyEx(monsters: monsters)

//: # 范型 vs 协议
//: ## 没有优劣之分，需求的取向，决定采用的不同。
//: ### 当类型在Compile-time确定的时候，使用范型。编译时的类型确定，同时也提供了性能，即使很难感受到。
//: ### 当类型在Run-time确定的时候，且类型可以混合的时候，使用协议。
//: ### 使用协议作为类型的时候，只有协议公开的 属性和方法才能被使用。
//: ###   当然，也可以强制转换为指定的类型。但是，这也脱离了设计的协议的初衷：协议就是要抹除具体类型的处理，使用协议定义内容。

//: ## 当我们定义一个满足业务的需求时，不是非此即彼的设计，而是将【范型-协议】混合使用。

//: [目录](目录) - [Previous page](@previous) - [Next page](@next)
