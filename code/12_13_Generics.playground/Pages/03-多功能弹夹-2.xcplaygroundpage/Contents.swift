//: [目录](目录) - [Previous page](@previous) - [Next page](@next)

import Foundation

//: # 多功能弹夹 - 2
//: ## 擦除类型

//: ## 子弹协议
protocol BulletProtocol: Comparable, Identifiable {
    var type: String { get }
    var speed: Int { get }
    init(type: String, speed: Int)
    func getBulletInfo(gunName: String) -> String
}

//: ## 使用扩展，给出 Identifiable 协议的一个默认实现。
extension BulletProtocol {
    
    var id: String { "\(type)- \(speed)" }
    
    func getBulletInfo(gunName: String) -> String {
        print("id: \(self.id), gunName:\(gunName)")
        print("gunName:\(gunName)")
        return self.id + gunName
    }
}

//: ## 给出一个“中间层”，擦除实现BulletProtocol的类型。中间层也实现BulletProtocol协议。
struct AnyBullet: BulletProtocol {
  
  var type: String 
  var speed: Int
  private var wrappedGetBulletInfo: ((String) -> String)?

  init(type: String , speed: Int) {
     self.type = type
     self.speed = speed
  }
    

//: ## 注意这里的构造方法
  init<B: BulletProtocol>(_ bullet: B) {
      type = bullet.type
      speed = bullet.speed
      wrappedGetBulletInfo = bullet.getBulletInfo(gunName:)
  }

  func getBulletInfo(gunName: String) -> String {
      wrappedGetBulletInfo?(gunName) ?? "No Bullet Information"
  }

  public static func == (lhs: AnyBullet, rhs: AnyBullet) -> Bool {
      lhs.speed == rhs.speed
  }
  
  static func < (lhs: AnyBullet, rhs: AnyBullet) -> Bool {
        return lhs.speed < rhs.speed
  }
}

// let xx: Comparable = Bullet(type: "T1", speed: 130)
let xx: AnyBullet = AnyBullet(type: "T1", speed: 130)
//: ## 子弹类型 BulletTypeA
struct BulletTypeA: BulletProtocol {
    var type: String
    var speed: Int
    
    init(type: String , speed: Int) {
        self.type = type
        self.speed = speed
    }
    
    static func < (lhs: BulletTypeA, rhs: BulletTypeA) -> Bool {
        return lhs == rhs && lhs.speed < rhs.speed
    }
}

//: ## 子弹类型 BulletTypeB
struct BulletTypeB: BulletProtocol {
    var type: String
    var speed: Int
    
    init(type: String , speed: Int) {
        self.type = type
        self.speed = speed
    }
    
    static func < (lhs: BulletTypeB, rhs: BulletTypeB) -> Bool {
        return lhs == rhs && lhs.speed < rhs.speed
    }
}

//: ## 协议的扩展，给出了子弹对象的默认生成。
//: ## some 可以屏蔽外部对内部类型的直接访问。
extension BulletProtocol {
    
    func asAnyBullet() -> AnyBullet {
        AnyBullet(self)
    }
    
    static func bulletTypeA() -> some BulletProtocol {
        BulletTypeA(type: "Defalut-typeA", speed: 0)
    }
    
    static func bulletTypeB() -> some BulletProtocol {
        BulletTypeB(type: "Defalut-typeB", speed: 0)
    }
}

// 类型擦除接口示例
BulletTypeA(type: "Defalut-typeA", speed: 0).asAnyBullet()
BulletTypeB(type: "Defalut-typeB", speed: 0).asAnyBullet()

AnyBullet(BulletTypeA(type: "Defalut-typeA", speed: 0))
AnyBullet(BulletTypeB(type: "Defalut-typeB", speed: 0))

let bulletA = AnyBullet.bulletTypeA()
bulletA.getBulletInfo(gunName: "X-type-gun")
let bulletB = AnyBullet.bulletTypeB()
bulletB.getBulletInfo(gunName: "XX-type-gun")

//: ## 枪协议
protocol GunProtocol {
    associatedtype T
    var gunName: String { set get }
    var bullets: [T] { set get }
    init(gunName: String)
    mutating func addBullet(_ bullet: T)
    mutating func shoot() -> T?
    mutating func sortBullets()
}

//: ## 一种枪支对象，可以使用各种类型的子弹。 子弹类型的类型被AnyBullet 代替。
struct Gun: GunProtocol {
    
    typealias T = AnyBullet
    
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
    
    func sortBullets() {
        gun.sortBullets()
    }
    
}

let wolfMan = MonsterArmedWolf<Gun>(name: "武装的狼人1号")

wolfMan.addBullet(bullet: BulletTypeA(type: "T1-typeA", speed: 100).asAnyBullet())
wolfMan.addBullet(bullet: AnyBullet(BulletTypeB(type: "T1-typeB", speed: 140)))

wolfMan.addBullet(bullet: AnyBullet(AnyBullet.bulletTypeA()))
wolfMan.addBullet(bullet: AnyBullet(AnyBullet.bulletTypeB()))

wolfMan.sortBullets()

wolfMan.useWeanpon()
wolfMan.useWeanpon()


//: [目录](目录) - [Previous page](@previous) - [Next page](@next)
