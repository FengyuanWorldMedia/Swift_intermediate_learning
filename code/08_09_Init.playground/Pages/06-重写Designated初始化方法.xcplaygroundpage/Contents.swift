//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)

//: # 重写Designated初始化方法

import Foundation

//: ### Convenience initializers
//: ### Convenience initializers 可以调用 Convenience 初始化方法，但是最后都会调用 designated initializers
class MonsterWolf {
    var name: String
    var ranking: Int
    var desc: String?
    
    init(name: String) {
        print("MonsterWolf ## init(name: String)")
        self.name = name
        self.ranking = 15
    }
    
    convenience init(name: String , desc: String?) {
        print("MonsterWolf ## convenience init(name: String , desc: String?)")
        self.init(name: name)
        self.desc = desc
    }
    
    convenience init(name: String ,ranking: Int, desc: String?) {
        print("MonsterWolf ## convenience init(name: String ,ranking: Int, desc: String?)")
        self.init(name: name, desc: desc)
        self.ranking = ranking
    }
}

//: ### 重写父类的Designated初始化方法， 可以让 收回的convenience 初始化方法，又可以 重新使用了 😊
//: ### 可以看出，在使用继承的 convenience 初始化方法，最后是调用了 重写的 Designated初始化方法，最后调用了 父类的 Designated 初始化方法。
//: ### 体会父类中self 的含义，如果调用发生在子类对象，则 在父类中的 self代表 【当前子类对象】。
class MonsterWolfWithDefalutPointSubClass : MonsterWolf {
     
    var point: Int
    
    override init(name: String) {    // 重写父类的Designated初始化方法
        print("MonsterWolfWithDefalutPointSubClass  ## init(name: String)")
        self.point = 0             // 给point默认值
        super.init(name: name)
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

let superWolf1 = MonsterWolfWithDefalutPointSubClass(name: "怪兽超级狼人1号")
let superWolf2 = MonsterWolfWithDefalutPointSubClass(name: "怪兽超级狼人2号", desc: "在漆黑的夜里行动")
let superWolf3 = MonsterWolfWithDefalutPointSubClass(name: "怪兽超级狼人3号", ranking: 15, desc: "在漆黑的夜里行动")
superWolf3.killAction()
superWolf3.killAction()
superWolf3.killAction()
superWolf3.killAction()
superWolf3.runAction()


//: ### 增加一个 Designated初始化方法， 使用外部参数， 完成 Point的初始化。同时 也不影响 继承父类的 convenience 初始化方法。
//: ### 注意⚠️：调用继承父类的 convenience 初始化方法，Point是默认值 0 .

//: ### 通过这示例我们可以得出一个重要的结论：
//: ### ‼️convenience初始化方法，在类中横向调用；而 Designated初始化方法在 子类中可以 纵向调用‼️

class MonsterWolfWithPointSubClass : MonsterWolf {
     
    var point: Int
    
    override init(name: String) {    // 重写父类的Designated初始化方法
        self.point = 0             // 给point默认值0
        super.init(name: name)
    }
    
    init(name: String, point: Int) { // 增加 Designated初始化方法，调用 父类的 Designated初始化方法
        self.point = point
        super.init(name: name)
    }
    
    convenience init(name: String, point: Int, desc: String?) {
        // 增加 子类 convenience 初始化方法，调用子类 Designated初始化方法
        self.init(name: name, point: point)
        //  self.init(name: name)  /// 想一想，为什么 不直接使用 【override init(name: String)】 ？？？？
        self.desc = desc
    }
    
    // 子类的convenience初始化方法 调用父类 Designated初始化方法错误
    // Convenience initializer for 'MonsterWolfWithPointSubClass' must delegate (with 'self.init') rather than chaining to a superclass initializer (with 'super.init')
    // convenience init(name: String, point: Int, ranking: Int ,desc: String?) { // 增加 子类 convenience 初始化方法，调用子类 Designated初始化方法
    //     self.point = point
    //     self.desc = desc
    //     self.ranking = ranking
    //     super.init(name: name)
    // }
    
    func killAction() -> Void {
        point += 1
        print("\(self.name)-必杀技-出招, 当前分数:\(point)")
    }
    
    func runAction() -> Void {
        point -= 1
        print("\(self.name)-必杀技-逃跑, 当前分数:\(point)")
    }
    
}


let superWolf4 = MonsterWolfWithPointSubClass(name: "怪兽超级狼人1号")
let superWolf5 = MonsterWolfWithPointSubClass(name: "怪兽超级狼人2号", desc: "在漆黑的夜里行动")
let superWolf6 = MonsterWolfWithPointSubClass(name: "怪兽超级狼人3号", ranking: 15, desc: "在漆黑的夜里行动")

// 给point 进行初始化
let superWolf7 = MonsterWolfWithPointSubClass(name: "怪兽超级狼人1号", point: 150)



//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)
