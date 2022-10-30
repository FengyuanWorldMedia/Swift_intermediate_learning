//: [目录](目录) - [Previous page](@previous) - [Next page](@next)

import Foundation

//: # 协议扩展中的构造方法
//: ## 协议扩展中，比较难以理解的是 默认构造方法的定义。

//: # 狼人协议的定义
protocol MonsterProtocol {
    
    // 魔法值
    var majicaPoint : Int { get set }
    
    // 初始化，不需要默认实现。实际上，也给不出 无参数构造方法的默认实现。 因为： 会产生 构造方法的递归调用。
    // 为了实现 有参数构造方法的默认实现，这里的 init() 声明是必须的。
    init()
    
    // 初始化，想定需要一个默认实现。
    init(majicaPoint: Int)
    
    func runAction() -> Void
}

//: ## 使用扩展给出的默认方法实现，在具体的类型中，是可以忽略其实现的。
extension MonsterProtocol {
    
    // 给出构造方法的默认实现，这里 必须调用self.init(); 否则报错: 'self' used before 'self.init' call or assignment to 'self'
    init(majicaPoint: Int) {
        self.init() // 这一句，是必须的。
        self.majicaPoint = majicaPoint
    }
    
    // 给出了runAction的默认方法。
    func runAction() {
        print("MonsterProtocol --> Run action")
    }
}

class MonsterWolfMan: MonsterProtocol {
    var majicaPoint = 0
    required init() {} //如果不是fianl class ，这里 需要加上 required 关键字。
}

final class MonsterWolfManFinal : MonsterProtocol {
    var majicaPoint = 0
    init() {} //如果是fianl class ， required 关键字 可以省略。
}


//: ## 使用了狼人协议默认实现的 有参构造方法。
let mnsterWolfMan = MonsterWolfMan(majicaPoint: 100)
mnsterWolfMan.majicaPoint // 100
mnsterWolfMan.runAction()

//: [目录](目录) - [Previous page](@previous) - [Next page](@next)
