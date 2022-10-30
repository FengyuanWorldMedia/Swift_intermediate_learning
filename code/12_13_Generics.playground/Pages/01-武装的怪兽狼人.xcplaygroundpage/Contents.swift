//: [目录](目录) - [Previous page](@previous) - [Next page](@next)

import Foundation

//: # 武装的怪兽狼人
//: ## 代码过多或类型转换的问题

// 武器-刀
struct WeaponKnife {
    var name = "Knife"
    var num: Int
}
// 武器-剑
struct WeaponSword {
    var name = "Sword"
    var num: Int
}
// 武器-匕首
struct WeaponDagger {
    var name = "Dagger"
    var num: Int
}
// 武器-锤子
struct WeaponHammer {
    var name = "Hammer"
    var num: Int
}

class MonsterWolf {
    var name: String
    var ranking: Int
    var desc: String?
    
    private(set) var weaponKnives = [WeaponKnife]()
    private(set) var weaponSwords = [WeaponSword]()
    private(set) var weaponDaggers = [WeaponDagger]()
    private(set) var weaponHammers = [WeaponHammer]()
    
    init(name: String) {
        self.name = name
        self.ranking = 15
        self.desc = "我是一只武装的怪兽-狼人"
        for i in 1...10 {
            weaponKnives.append(WeaponKnife(num: i))
            weaponSwords.append(WeaponSword(num: i))
            weaponDaggers.append(WeaponDagger(num: i))
            weaponHammers.append(WeaponHammer(num: i))
        }
    }
    
    func throwKnifeAction() -> WeaponKnife? {
        if weaponKnives.isEmpty {
            return nil
        }
        let knife = weaponKnives.removeFirst()
        print("扔出一个 - 飞刀")
        return knife
    }
    func throwSwordAction() -> WeaponSword? {
        if weaponSwords.isEmpty {
            return nil
        }
        let sword = weaponSwords.removeFirst()
        print("扔出一个 - 剑")
        return sword
    }
    func throwDaggerAction() -> WeaponDagger? {
        if weaponDaggers.isEmpty {
            return nil
        }
        let dagger = weaponDaggers.removeFirst()
        print("扔出一个 - 匕首")
        return dagger
    }
    func throwHammerAction() -> WeaponHammer? {
        if weaponHammers.isEmpty {
            return nil
        }
        let hammer = weaponHammers.removeFirst()
        print("扔出一个 - 铁锤")
        return hammer
    }
    
}

//: ## 武器如果持续增加，对应的 使用武器技能动作也会持续增加，代码也会越来越多😠

//: ## 武器的结构 和 使用武器动作 类似，是否可以统一管理？

//: ## 改善后的情况。

class MonsterWolfEx {
    var name: String
    var ranking: Int
    var desc: String?
    
    private(set) var weapons = [Any]()
    
    init(name: String) {
        self.name = name
        self.ranking = 15
        self.desc = "我是一只武装的怪兽-狼人"
        for i in 1...10 {
            weapons.append(WeaponKnife(num: i))
            weapons.append(WeaponSword(num: i))
            weapons.append(WeaponDagger(num: i))
            weapons.append(WeaponHammer(num: i))
        }
    }
    
//: ## 使用Any改善了代码的长度，但是 具体的类型判断和转换，仍然没有办法避免？！
    func throwWeaponAction() -> Any? {
        if weapons.isEmpty {
            return nil
        }
        let weapon = weapons.removeFirst()
        var weaponName = ""
        switch weapon {
            case let w as WeaponKnife : weaponName = w.name
            case let w as WeaponSword : weaponName = w.name
            case let w as WeaponDagger : weaponName = w.name
            case let w as WeaponKnife : weaponName = w.name
            default:
                weaponName = "这个武器没有名字"
        }
        print("扔出一个武器 - 武器的名字：\(weaponName)")
        return weapon
    }
}




//: [目录](目录) - [Previous page](@previous) - [Next page](@next)
