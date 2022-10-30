//: [目录](目录) - [Previous page](@previous) - [Next page](@next)

import Foundation

//: # 协议扩展中的构造方法(添加)
//: ## 在协议扩展中增加方法，对是所有的 遵循协议的对象 有效。
//: ## 在结构体或类扩展中增加方法，对是此 结构体或类的 对象 有效。
//: ## 使用时，根据业务选择合适的【扩展范围】。

//: # 狼人协议的定义
protocol MonsterProtocol {
    
    // 魔法值
    var majicaPoint : Int { get set }
    
    // 初始化，不需要默认实现。实际上，也给不出 无参数构造方法的默认实现。 因为： 会产生 构造方法的递归调用。
    // 为了实现 有参数构造方法的默认实现，这里的 init() 声明是必须的。
    init()
    
    func runAction() -> Void
}

//: ## 使用扩展给出的默认方法实现，在具体的类型中，是可以忽略其实现的。
extension MonsterProtocol {
    
    // 在扩展中增加 有参数构造方法，这里 必须调用self.init(); 否则报错: 'self' used before 'self.init' call or assignment to 'self'
    init(majicaPoint: Int) {
        self.init() // 这一句，是必须的。
        self.majicaPoint = majicaPoint
    }
    // 给出了runAction的默认方法。
    func runAction() {
        print("MonsterProtocol --> Run action")
    }
    // 增加给出了killAction的方法。
    func killAction() {
        print("MonsterProtocol --> Kill action")
    }
}

class MonsterWolfMan: MonsterProtocol {
    var majicaPoint = 0
    required init() {} //如果不是fianl class ，这里 需要加上 required 关键字。
}

extension MonsterWolfMan {
    func bellowAction() {
        print("MonsterWolfManFinal --> bellow action")
    }
}

class MonsterWolfMan2: MonsterWolfMan {
    required init() {}
}

let monster2 = MonsterWolfMan2()
monster2.bellowAction()

final class MonsterWolfManFinal : MonsterProtocol {
    var majicaPoint = 0
    init() {} //如果是fianl class ， required 关键字 可以省略。
}

// 为 MonsterWolfManFinal 扩展方法。
extension MonsterWolfManFinal {
    func bellowAction() {
        print("MonsterWolfManFinal --> bellow action")
    }
}


//: ## 使用了狼人协议默认实现的 有参构造方法。
let mnsterWolfMan = MonsterWolfMan(majicaPoint: 100)
mnsterWolfMan.majicaPoint // 100
mnsterWolfMan.runAction()

mnsterWolfMan.killAction()


//: [目录](目录) - [Previous page](@previous) - [Next page](@next)
