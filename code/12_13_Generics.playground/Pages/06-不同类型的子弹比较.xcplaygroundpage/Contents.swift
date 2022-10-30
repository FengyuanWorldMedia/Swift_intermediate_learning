//: [目录](目录) - [Previous page](@previous) - [Next page](@next)

import Foundation


//: ### 扩展Array ，使其转为Set 类型.
extension Array {
    func mapToSet<T: Hashable>(_ transform: (Element) -> T) -> Set<T> {
        var result = Set<T>()
        for item in self {
            result.insert(transform(item))
        }
        return result
    }
}

struct Bullet_TypeA {
    var type: String
    var speed: Int
}

struct BulletA_Container {
    
    var bulletDic: Dictionary<String , Bullet_TypeA> = [:]
    
    mutating func addBulletA(key: String , bullet: Bullet_TypeA) {
        self.bulletDic[key] = bullet
    }
    
//: ### 如果有相同type 的情况下，进行速度比较，速度快的 记分加一。
//: ### 对比后，如果当前弹夹比 参数的分数高，则返回true；反之，false。
    func morePowerfull(than: BulletB_Container) -> Bool {
        
        let keys = Array(bulletDic.keys).mapToSet({$0})
        let keys2 = Array(than.bulletDic.keys).mapToSet({$0})
        let sameBullets = keys.intersection(keys2)
        var winCount = 0
        for e in sameBullets {
            if self.bulletDic[e]!.speed == than.bulletDic[e]!.speed {
                continue
            } else if self.bulletDic[e]!.speed > than.bulletDic[e]!.speed {
                winCount += 1
            } else {
                winCount -= 1
            }
        }
        
        return winCount > 0
    }
}

struct Bullet_TypeB {
    var type: String
    var speed: Int
}

struct BulletB_Container {
    
    var bulletDic: Dictionary<String , Bullet_TypeB> = [:]
    
    mutating func addBulletB(key: String , bullet: Bullet_TypeB) {
        self.bulletDic[key] = bullet
    }
    func morePowerfull(than: BulletA_Container) -> Bool {
        let keys = Array(bulletDic.keys).mapToSet({$0})
        let keys2 = Array(than.bulletDic.keys).mapToSet({$0})
        let sameBullets = keys.intersection(keys2)
        var winCount = 0
        for e in sameBullets {
            if self.bulletDic[e]!.speed == than.bulletDic[e]!.speed {
                continue
            } else if self.bulletDic[e]!.speed > than.bulletDic[e]!.speed {
                winCount += 1
            } else {
                winCount -= 1
            }
        }
        return winCount > 0
    }
}


var containerA = BulletA_Container()
containerA.addBulletA(key: "第1发子弹", bullet: Bullet_TypeA(type: "A-1", speed: 17))
containerA.addBulletA(key: "第2发子弹", bullet: Bullet_TypeA(type: "A-1", speed: 18))

var containerB = BulletB_Container()
containerB.addBulletB(key: "第1发子弹", bullet: Bullet_TypeB(type: "A-1", speed: 17))
containerB.addBulletB(key: "第2发子弹", bullet: Bullet_TypeB(type: "B-1", speed: 16))
containerB.addBulletB(key: "第3发子弹", bullet: Bullet_TypeB(type: "B-2", speed: 15))


let winFlag = containerA.morePowerfull(than: containerB)
print(winFlag)

//: ## 改进子弹比较方法
struct Bullet_TypeA_Ex: Hashable, Comparable {
    var type: String
    var speed: Int
    
    static func < (lhs: Bullet_TypeA_Ex, rhs: Bullet_TypeA_Ex) -> Bool {
        return lhs.speed < rhs.speed
    }
    
    static func == (lhs: Bullet_TypeA_Ex, rhs: Bullet_TypeA_Ex) -> Bool {
        return lhs.speed == rhs.speed
    }
}
struct Bullet_TypeB_Ex: Hashable, Comparable {
    var type: String
    var speed: Int
    
    static func < (lhs: Bullet_TypeB_Ex, rhs: Bullet_TypeB_Ex) -> Bool {
        return lhs.speed < rhs.speed
    }
    static func == (lhs: Bullet_TypeB_Ex, rhs: Bullet_TypeB_Ex) -> Bool {
        return lhs.speed == rhs.speed
    }
}

let testBulletA1 = Bullet_TypeA_Ex(type: "type1", speed: 100)
let testBulletA2 = Bullet_TypeA_Ex(type: "type2", speed: 100)
print(testBulletA1 < testBulletA2)
print(testBulletA1 == testBulletA2)
//: ## 改进后，子弹为可以直接进行比较，因为需要实现 Comparable 协议。
//: ## Comparable 协议，约束了 比较的类型必须是 一样的。
struct BulletContainer<B: Comparable & Hashable> {
    
    var bulletDic: Dictionary<String , B> = [:]
    
    mutating func addBullet(key: String , bullet: B) {
        self.bulletDic[key] = bullet
    }
    
    func morePowerfull(than: BulletContainer<B>) -> Bool {
        let keys = Array(bulletDic.keys).mapToSet({$0})
        let keys2 = Array(than.bulletDic.keys).mapToSet({$0})
        let sameBullets = keys.intersection(keys2)
        var winCount = 0
        for e in sameBullets {
            print(e)
            let oneBullet = self.bulletDic[e]!
            let anotherBullet = than.bulletDic[e]!
            if oneBullet == anotherBullet {
                continue
            } else if oneBullet > anotherBullet {
                winCount += 1
            } else {
                winCount -= 1
            }
        }
        return winCount > 0
    }
}

//: ### 只有装了同样类型的子弹，才可以进行比较。
var container1 = BulletContainer<Bullet_TypeA_Ex>()
container1.addBullet(key: "第1发子弹", bullet: Bullet_TypeA_Ex(type: "A-1", speed: 17))
container1.addBullet(key: "第2发子弹", bullet: Bullet_TypeA_Ex(type: "A-1", speed: 16))

var container2 = BulletContainer<Bullet_TypeA_Ex>()
container2.addBullet(key: "第1发子弹", bullet: Bullet_TypeA_Ex(type: "A-1", speed: 17))
container2.addBullet(key: "第2发子弹", bullet: Bullet_TypeA_Ex(type: "B-1", speed: 16))
container2.addBullet(key: "第3发子弹", bullet: Bullet_TypeA_Ex(type: "B-2", speed: 15))
let winFlag2 = container1.morePowerfull(than: container2)
print(winFlag2)


//: ### 只有装了同样类型的子弹，才可以进行比较。
var container3 = BulletContainer<Bullet_TypeB_Ex>()
container3.addBullet(key: "第1发子弹", bullet: Bullet_TypeB_Ex(type: "A-1", speed: 17))
container3.addBullet(key: "第2发子弹", bullet: Bullet_TypeB_Ex(type: "A-1", speed: 18))

var container4 = BulletContainer<Bullet_TypeB_Ex>()
container4.addBullet(key: "第1发子弹", bullet: Bullet_TypeB_Ex(type: "A-1", speed: 17))
container4.addBullet(key: "第2发子弹", bullet: Bullet_TypeB_Ex(type: "B-1", speed: 16))
container4.addBullet(key: "第3发子弹", bullet: Bullet_TypeB_Ex(type: "B-2", speed: 15))
let winFlag3 = container3.morePowerfull(than: container4)
print(winFlag3)


//: ### 想一想，如何才能实现不同子弹的 弹夹进行比较？？
// 提醒： 😄AnyBullet😄

//: [目录](目录) - [Previous page](@previous) - [Next page](@next)




