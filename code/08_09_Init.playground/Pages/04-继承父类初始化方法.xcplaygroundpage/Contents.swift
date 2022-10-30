//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)

//: # 继承父类初始化方法

import Foundation

//: ### Convenience initializers
//: ### Convenience initializers 可以调用 Convenience 初始化方法，但是最后都会调用 designated initializers
class MonsterWolf {
    var name: String
    var ranking: Int
    var desc: String?
    
    init(name: String) {
        self.name = name
        self.ranking = 15
        print("MonsterWolf ## init(name: String)")
    }
    
    convenience init(name: String , desc: String?) {
        self.init(name: name)
        self.desc = desc
        print("MonsterWolf ## convenience init(name: String , desc: String?)")
    }
    
    convenience init(name: String ,ranking: Int, desc: String?) {
        self.init(name: name, desc: desc)
        self.ranking = ranking
        print("MonsterWolf ## convenience init(name: String ,ranking: Int, desc: String?)")
    }
}

// let monsterWolf1 = MonsterWolf(name: "怪兽狼人1号")
// let monsterWolf2 = MonsterWolf(name: "怪兽狼人2号", desc: "在漆黑的夜里行动")
// let monsterWolf3 = MonsterWolf(name: "怪兽狼人2号", ranking: 15, desc: "在漆黑的夜里行动")

//: ## MonsterWolfSubClass 继承了 MonsterWolf； 同时 MonsterWolf中的初始化方法 一并继承
class MonsterWolfSubClass: MonsterWolf {
    
    func killAction() -> Void {
        print("\(self.name)-必杀技-出招")
    }
    
    func runAction() -> Void {
        print("\(self.name)-必杀技-逃跑")
    }
    
}

let superWolf1 = MonsterWolfSubClass(name: "怪兽超级狼人1号")
superWolf1.killAction()
superWolf1.runAction()
print("")
let superWolf2 = MonsterWolfSubClass(name: "怪兽超级狼人2号", desc: "在漆黑的夜里行动")
superWolf2.killAction()
superWolf2.runAction()
print("")
let superWolf3 = MonsterWolfSubClass(name: "怪兽超级狼人2号", ranking: 15, desc: "在漆黑的夜里行动")
superWolf3.killAction()
superWolf3.runAction()


//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)


