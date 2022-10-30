//: [回到目录](目录) - [Previous page](@previous)

import Foundation

//: # 怪兽生产工厂

protocol MonsterProtocol {
     init(name: String ,ranking: Int, desc: String?)
}

//: ## 怪兽生产工厂类设计
final class MonsterCreator {
    
    private(set) static var monsterCount: Int = 0
    
    // 注意这里的接口设计
    static func create<T: MonsterProtocol>(type: T.Type, name: String ,ranking: Int, desc: String?) -> T {
        monsterCount += 1
        return T(name: name, ranking: ranking, desc: desc)
    }
}


class MonsterWolf : MonsterProtocol {
    var name: String
    var ranking: Int
    var desc: String?
    
    init(name: String) {
        self.name = name
        self.ranking = 15
    }
     
    // 在 static create方法中使用 init的话，必须是 required 类型的初始化 方法。
    required convenience init(name: String ,ranking: Int, desc: String?) {
        self.init(name: name)
        self.ranking = ranking
        self.desc = desc
    }
    
    func clone() -> MonsterWolf {
        let clone = MonsterWolf.init(name: self.name, ranking: self.ranking, desc: self.desc)
        return clone
    }
}

  
class MonsterDragon : MonsterProtocol {
    var name: String?
    var ranking: Int?
    var desc: String?
    
    init() {
        
    }
    
    required init(name: String , ranking: Int , desc: String? = nil) {
        self.name = name
        self.ranking = ranking
        self.desc = desc
    }
}
 


let monsterWolf = MonsterCreator.create(type: MonsterWolf.self, name: "狼人", ranking: 15, desc: "还有谁？")
print(monsterWolf.name)
print(monsterWolf.ranking)
print(monsterWolf.desc ?? "没有描述")

let monsterWolfClone = monsterWolf.clone()
monsterWolfClone.desc = "克隆狼人"

print(monsterWolf.desc!)
print(monsterWolfClone.desc!)

print("")

let monsterDragon = MonsterCreator.create(type: MonsterDragon.self, name: "恶龙", ranking: 16, desc: "还有我。。")
print(monsterDragon.name!)
print(monsterDragon.ranking!)
print(monsterDragon.desc ?? "没有描述")

print("")
print("产生怪兽对象个数：\(MonsterCreator.monsterCount)")

//: [回到目录](目录) - [Previous page](@previous)



