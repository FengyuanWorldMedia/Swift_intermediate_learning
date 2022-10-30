//: [目录](目录) - [Previous page](@previous) - [Next page](@next)

import Foundation

//: # 多功能弹夹
//: ## Equatable和 Comparable协议

//: ## 子弹协议
protocol BulletProtocol: Comparable, Identifiable {
    var type: String { get }
    var speed: Int { get }
    init(type: String, speed: Int)
}

extension BulletProtocol {
    
    var id: String { "\(type)- \(speed)" }
}

struct Bullet: BulletProtocol {
    var type: String
    var speed: Int
    init(type: String , speed: Int) {
        self.type = type
        self.speed = speed
    }
    
    static func < (lhs: Bullet, rhs: Bullet) -> Bool {
        return lhs.speed < rhs.speed
    }
    
    static func == (lhs: Bullet, rhs: Bullet) -> Bool {
        return lhs.speed == rhs.speed
    }
}



//: ## ⚠️注意点：
//: ### 1.Comparable 协议继承自 Equatable
//: ### 2.Comparable 唯一要求必须实现 < 的实现。 其他的可以选择实现。
//: ### 3.对结构体来讲，如果 实现协议Equatable 的话，Swift会自动 实现Equatable协议，对所有的成员变量 相等时，就认为这两个结构体的对象相等。
//: ### 4.显然，大多数情况下，我们需要覆盖Swift提供的Equatable实现。
//: ### 5.这样 有了< 的实现和 == 的实现后， 其他的 <= , >= , > 会被自动的被Swift组装。同时，也可以根据业务需求进行覆盖。
//: ### 6.实现 Comparable 协议的 对象，可以进行对比。（或者，在数组中进行对比，排序等等操作）
//: ### 7.Protocol 'Equatable' can only be used as a generic constraint because it has Self or associated type requirements.
//: ###     解释: 含有 Self 或关联类型的协议只能用作泛型约束，不能单独作为类型使用

//let lhs: Equatable = 1           // Int
//let rsh: Equatable = "1"         // String
//let lhs: Comparable = 1          // Int
//let rsh: Comparable = "1"        // String


//: ## Protocol 'Comparable' can only be used as a generic constraint because it has Self or associated type requirements
//: ### Generics 是[编译期]特性，在编译时就能明确泛型的具体类型，故有 Self requirements/Associated Type 的 Protocol 只能作为其约束使用。
//: ### Protocol 是[运行时]特性，而其附带的 Self requirements / Associated Type 却需要在编译时保证。
// let xx: Comparable = Bullet(type: "T1", speed: 130)

//: ## 按照Speed 升序排列
func sort<T: Comparable>(_ array: [T]) -> [T] {
    return array.sorted(by: <)
}

var bullets = [Bullet]()
bullets.append(Bullet(type: "T1", speed: 130))
bullets.append(Bullet(type: "T2", speed: 120))
bullets = sort(bullets)

print(bullets)



//: ## 枪协议
protocol GunProtocol {
    associatedtype T: BulletProtocol
    var gunName: String { set get }
    var bullets: [T] { set get }
    init(gunName: String)
    mutating func addBullet(_ bullet: T)
    mutating func shoot() -> T?
}

// 一类枪支，只能使用同一款子弹, 每个子弹的出膛数度有可能不一样。
struct Gun: GunProtocol {
    
    typealias T = Bullet
    
    var gunName: String
    var bullets = [T]()
    
    init(gunName: String) {
        self.gunName = gunName
    }
    
    mutating func addBullet(_ bullet: T) {
        self.bullets.append(bullet)
    }
    
    mutating func shoot() -> T? {
        if bullets.isEmpty {
            return nil
        }
        return bullets.removeFirst()
    }
    
    mutating func sortBullets() {
        self.bullets = self.bullets.sorted(by: >)
    }
}


// 武装的 怪兽狼人
class MonsterArmedWolf<T: GunProtocol> {
    
    var name: String
    var ranking: Int
    var desc: String?
    
    private(set) var gun: T = T(gunName: "T1100")
    
    init(name: String) {
        self.name = name
        self.ranking = 15
        self.desc = "我是一只武装的怪兽-狼人"
    }
    
    func useWeanpon() -> T.T? {
        let bullet = gun.shoot()
        print("狼人:\(self.name), 使用了武器: \(gun.gunName), 子弹类型:\(bullet.debugDescription)")
       return bullet
    }
    
    func addBullet(bullet : T.T) {
        gun.addBullet(bullet)
    }
    
    func sortBullet() {
        self.gun.bullets.sorted(by: >)
    }
}

let wolfMan = MonsterArmedWolf<Gun>(name: "武装的狼人1号")


wolfMan.sortBullet()
wolfMan.addBullet(bullet: Bullet(type: "T1", speed: 100))
wolfMan.addBullet(bullet: Bullet(type: "T1", speed: 140))

wolfMan.useWeanpon()
wolfMan.useWeanpon()

print("-----------------------------------------------------------")

//: ## 更加灵活的定义
//: ### 在枪类型对象初始化的时候，指定 子弹类型。
//: ### 这样可以保证了一个 枪的类型，可以产生不 使用不同子弹的 枪。
//: ### 但，仍然是 一个枪对象 使用一种类型的 子弹。
struct GunEx<V: BulletProtocol>: GunProtocol {
    
    typealias T = V
    
    var gunName: String
    var bullets = [T]()
    
    init(gunName: String) {
        self.gunName = gunName
    }
    
    mutating func addBullet(_ bullet: T) {
        self.bullets.append(bullet)
    }
    
    mutating func shoot() -> T? {
        if bullets.isEmpty {
            return nil
        }
        return bullets.removeFirst()
    }
    
    /// Referencing instance method 'sorted()' on 'Sequence' requires that 'V' conform to 'Comparable'
    mutating func sort() {
        self.bullets.sorted()
    }
}

class MonsterArmedWolfEx<T: GunProtocol> {
    
    var name: String
    var ranking: Int
    var desc: String?
    
    var gun: T = T(gunName: "T1100")
    
    init(name: String) {
        self.name = name
        self.ranking = 15
        self.desc = "我是一只武装的怪兽-狼人"
    }
    
    func useWeanpon() -> T.T? {
        let bullet = gun.shoot()
        print("狼人:\(self.name), 使用了武器: \(gun.gunName), 子弹类型:\(bullet.debugDescription)")
        return bullet
    }
    
    func addBullet(bullet : T.T) {
        gun.addBullet(bullet)
    }
}

//: ### 理解的范型的指定（级联指定的写法）
//: ### 理解范型和 协议关联类型的 关系
let wolfMan2 = MonsterArmedWolfEx<GunEx<Bullet>>(name: "武装的狼人1号")
wolfMan2.gun.sort()
wolfMan2.addBullet(bullet: Bullet(type: "T1", speed: 100))
wolfMan2.addBullet(bullet: Bullet(type: "T1", speed: 140))

wolfMan2.useWeanpon()
wolfMan2.useWeanpon()

//: [目录](目录) - [Previous page](@previous) - [Next page](@next)
