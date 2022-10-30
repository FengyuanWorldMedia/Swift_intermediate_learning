//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)

//: # 减少初始化方法

import Foundation

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

//: ## 狼人二代初始化
class MonsterWolfSubClass : MonsterWolf {
     
    var point: Int
    
    override init(name: String) {
        self.point = 0
        super.init(name: name)
    }
    
    init(name: String, point: Int) {
        self.point = point
        super.init(name: name)
    }
    
    convenience init(name: String, point: Int, desc: String?) {
         self.init(name: name, point: point)
         self.desc = desc
    }
}

//: ## 狼人三代初始化
class MonsterWolfSubClass_3: MonsterWolfSubClass {
     
    var property: Int
    
    override init(name: String) {  // 如果想保留父类的 convenience，必须重写 父类的 Designated 初始化方法
        self.property = 0
        super.init(name: name, point: 0)
    }
    
    override init(name: String, point: Int) { // 如果想保留父类的 convenience，必须重写 父类的 Designated 初始化方法
        self.property = 0
        super.init(name: name, point: point)
    }
    
    init(name: String, property: Int, point: Int) {
        self.property = property
        super.init(name: name, point: point)
    }
    
    convenience init(name: String, property: Int,point: Int, desc: String?) {
        self.init(name: name, property: property, point: point)
        self.desc = desc
    }
}

let wolfMan3 = MonsterWolfSubClass_3(name: "第3代狼人", desc: "资产的增加")
/// -----

//: ## 扩展-狼人三代初始化
class MonsterWolfSubClassEx : MonsterWolf {
     
    var point: Int
    
    convenience override init(name: String) {
        print("MonsterWolfSubClassEx ## convenience override init(name: String)")
        self.init(name: name, point: 0)
    }
    
    init(name: String, point: Int) {
        print("MonsterWolfSubClassEx ## init(name: String, point: Int)")
        self.point = point
        super.init(name: name)
    }
    
    convenience init(name: String, point: Int, desc: String?) {
        print("MonsterWolfSubClassEx ## convenience init(name: String, point: Int, desc: String?)")
         self.init(name: name, point: point)
         self.desc = desc
    }
}

//: ## 扩展-狼人三代初始化
class MonsterWolfSubClassEx_3 : MonsterWolfSubClassEx {
     
    var property: Int
    
    convenience override init(name: String, point: Int) {
        self.init(name: name, point: point, property: 0)
    }
    
    init(name: String, point: Int, property: Int) {
        self.property = property
        super.init(name: name, point: point)
    }
    
    convenience init(name: String, property: Int, point: Int, desc: String?) {
        self.init(name: name, point: point, property: property)
        self.desc = desc
    }
}


let superWolf4 = MonsterWolfSubClassEx_3(name: "3代狼人-怪兽超级狼人1号")

print("")
let superWolf5 = MonsterWolfSubClassEx_3(name: "3代狼人-怪兽超级狼人2号", desc: "在漆黑的夜里行动")

print("")
let superWolf6 = MonsterWolfSubClassEx_3(name: "3代狼人-怪兽超级狼人3号", ranking: 15, desc: "在漆黑的夜里行动")

print("")
let superWolf7 = MonsterWolfSubClassEx_3(name: "3代狼人-怪兽超级狼人1号", point: 150)

let superWolf8 = MonsterWolfSubClassEx_3(name: "3代狼人-1", property: 500, point: 100, desc: "在漆黑的夜里行动")

//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)



