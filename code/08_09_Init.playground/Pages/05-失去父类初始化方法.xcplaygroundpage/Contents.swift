
//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)

//: # 失去父类初始化方法


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

//: ## MonsterWolfSubClass 继承了 MonsterWolf； 同时 MonsterWolf中的初始化方法 一并继承
//: ## 子类中增加 Optional属性，不会影响 继承的初始化方法。
class MonsterWolfSubClass : MonsterWolf {
    
    var point: Int?
    
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
let superWolf3 = MonsterWolfSubClass(name: "怪兽超级狼人3号", ranking: 15, desc: "在漆黑的夜里行动")
superWolf3.killAction()
superWolf3.runAction()


//: ## MonsterWolfSubClass 继承了 MonsterWolf
//: ## 子类中增加 非Optional属性，此时 继承父类的 初始化方法全部 被收回（非常遗憾）。
class MonsterWolfWithPointSubClass : MonsterWolf {
    
    // 如果不添加初始化方法，编译报错：Class 'MonsterWolfWithPointSubClass' has no initializers
    var point: Int
    
    // 必须先初始化 子类的属性 , 然后 通过 父类的 designated initializer 初始化 继承的 属性
    // 在子类的designated initializer 中， 不能调用父类的 convenience 初始化方法
    init(name: String, ranking: Int, point: Int, desc: String?) {
        self.point = point
        super.init(name: name)
        self.ranking = ranking
        self.desc = desc
    }
    
    func killAction() -> Void {
        point += 1
        print("\(self.name)-必杀技-出招, 当前分数:\(point)")
    }
    
    func runAction() -> Void {
        point -= 1
        print("\(self.name)-必杀技-逃跑, 当前分数:\(point)")
    }
    
}

let superWolf4 = MonsterWolfWithPointSubClass(name: "怪兽超级狼人4号", ranking: 15, point: 100, desc: "在漆黑的夜里行动")

superWolf4.killAction()
superWolf4.killAction()
superWolf4.killAction()
superWolf4.killAction()
superWolf4.runAction()

//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)
