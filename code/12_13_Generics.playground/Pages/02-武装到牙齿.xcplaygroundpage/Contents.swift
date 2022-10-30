//: [目录](目录) - [Previous page](@previous) - [Next page](@next)

import Foundation


//: # 武装的怪兽狼人
//: ## 范型在方法和类中的使用

//: ## 范型在方法中使用

protocol WeaponProtocol {
    var name: String { set get }
}
// 武器-刀
struct WeaponKnife: WeaponProtocol {
    var name = "Knife"
    var num: Int
}
// 武器-剑
struct WeaponSword: WeaponProtocol {
    var name = "Sword"
    var num: Int
}
// 武器-匕首
struct WeaponDagger: WeaponProtocol {
    var name = "Dagger"
    var num: Int
}
// 武器-锤子
struct WeaponHammer: WeaponProtocol {
    var name = "Hammer"
    var num: Int
}

class MonsterWolf {
    var name: String
    var ranking: Int
    var desc: String?
     
    
    init(name: String) {
        self.name = name
        self.ranking = 15
        self.desc = "我是一只武装的怪兽-狼人"
    }
    
//: ## 一个范型的定义，解决了4个方法的定义
//: ### 1.代码在编译后，可以认为同时拥有了对 武器【刀，剑，匕首，铁锤】的四个方法。
//: ### 2.编译器使用了优化技术，不用担心遍以后二进制文件变大。
//: ### 3.编译器使用value-witness-tables技术，进行具体的实现和执行（不在讨论范围内）。
//: ### 4.和Any不同的时，在编译的时候，你知道T是什么类型。
    func throwWeaponAction<T: WeaponProtocol>(weapon: T) -> T {
        print("扔出一个武器 - 武器的名字：\(weapon.name)")
        return weapon
    }

}

let wolfMan = MonsterWolf(name: "怪兽-狼人")
wolfMan.throwWeaponAction(weapon: WeaponKnife(name: "刀", num: 1))
wolfMan.throwWeaponAction(weapon: WeaponSword(name: "剑", num: 2))
wolfMan.throwWeaponAction(weapon: WeaponDagger(name: "匕首", num: 3))
wolfMan.throwWeaponAction(weapon: WeaponHammer(name: "铁锤", num: 4))


//: ### 多个范型的写法
extension MonsterWolf {
//: ### where 子句的学习
    func throwWeaponAction2<T>(weapon: T) -> T where T: WeaponProtocol {
        print("扔出一个武器 - 武器的名字：\(weapon.name)")
        return weapon
    }
//: ### 两个范型的使用
    func throwWeaponAction3<T: WeaponProtocol, V: WeaponProtocol>(weapon1: T, weapon2: V) -> (T, V) {
        print("扔出2个武器 - 武器1的名字：\(weapon1.name), 武器2的名字：\(weapon2.name)")
        return (weapon1, weapon2)
    }
//: ### 三个范型的使用
    func throwWeaponAction3<T, V, U>(weapon1: T, weapon2: V, weapon3: U) -> (T, V, U) where T: WeaponProtocol, V: WeaponProtocol , U: WeaponProtocol {
        print("扔出3个武器 - 武器1的名字：\(weapon1.name), 武器2的名字：\(weapon2.name) , 武器3的名字：\(weapon3.name)")
        return (weapon1, weapon2, weapon3)
    }
}

//: ## 百招会，不如一招精
//: ### 学习在类定义时，使用范型
class MonsterWolfEx<T: WeaponProtocol> {
    
    var name: String
    var ranking: Int
    var desc: String?
    
    init(name: String) {
        self.name = name
        self.ranking = 15
        self.desc = "我是一只武装的怪兽-狼人"
    }
    
    func throwWeaponAction(weapon: T) -> T {
        print("\(self.name) (最拿手的武器) 扔出一个武器 - 武器的名字：\(weapon.name)")
        return weapon
    }
}

let wolfMan1 = MonsterWolfEx<WeaponKnife>(name: "怪兽1-狼人")
let wolfMan2 = MonsterWolfEx<WeaponSword>(name: "怪兽2-狼人")
let wolfMan3 = MonsterWolfEx<WeaponDagger>(name: "怪兽3-狼人")
let wolfMan4 = MonsterWolfEx<WeaponHammer>(name: "怪兽4-狼人")

wolfMan1.throwWeaponAction(weapon: WeaponKnife(name: "刀", num: 1))
wolfMan2.throwWeaponAction(weapon: WeaponSword(name: "剑", num: 2))
wolfMan3.throwWeaponAction(weapon: WeaponDagger(name: "匕首", num: 3))
wolfMan4.throwWeaponAction(weapon: WeaponHammer(name: "铁锤", num: 4))

//: ### 也可以保留原来的功能
extension MonsterWolfEx {
    func throwWeaponAction<U>(weapon: U) -> U where U: WeaponProtocol {
        print("\(self.name) (陌生的武器) 扔出一个武器 - 武器的名字：\(weapon.name)")
        return weapon
    }
}

wolfMan1.throwWeaponAction(weapon: WeaponSword(name: "剑", num: 2))

//: [目录](目录) - [Previous page](@previous) - [Next page](@next)
