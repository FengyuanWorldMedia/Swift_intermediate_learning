//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)

//: # descendant 通过反射更简单的获取属性值

import Foundation

class WolfMan {
    var name: String
    init(name:String) {
        self.name = name
    }
}

final class Monster {
    var name: String
    var ranking: Int
    var desc: String?
    
    init(name: String, ranking: Int, desc: String?) {
        self.name = name
        self.ranking = ranking
        self.desc = desc
    }
    
    var follower1: WolfMan = WolfMan(name: "狼人1号") // 部下1
    var follower2: WolfMan? // 部下2
}


let monster = Monster(name: "怪兽0号", ranking: 10, desc: "最棒的一个士兵")
monster.follower2 = WolfMan(name: "狼人2号")
dump(monster)

let monsterMirror = Mirror(reflecting: monster)

print ("部下：狼人1号的名字： \(monsterMirror.descendant("follower1", "name") ?? "获取不到")")

//: ## 特别⚠️注意： Optional 的属性时候，后续的 keypath即使指定了，也获取不到值。 😅
print ("部下：狼人2号的等级： \(monsterMirror.descendant("follower2", "some", "name") ?? "获取不到")")

//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)
