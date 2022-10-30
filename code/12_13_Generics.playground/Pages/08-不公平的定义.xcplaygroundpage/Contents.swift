//: [目录](目录) - [Previous page](@previous) - [Next page](@next)

import Foundation

//: # 范型和子类
//: ## 自定义 vs Built-in

//: ### 定义子弹类型
class Bullet: Hashable, Comparable {
    var type: String
    var speed: Int
    
    init(type: String, speed: Int) {
        self.type = type
        self.speed = speed
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
    
    static func < (lhs: Bullet, rhs: Bullet) -> Bool {
        return lhs.speed < rhs.speed
    }
    
    static func == (lhs: Bullet, rhs: Bullet) -> Bool {
        return lhs.speed == rhs.speed
    }
}

//: ### 定义子弹类型子类
class SubBullet : Bullet {
    var maker = "Default maker"
}

//: ### 自定义 容器
struct BulletContainer<B: Comparable & Hashable> {
     // 省略内容
}

//: ### 定义参数是Optional，范型类型指定为 Bullet
func test(bullet: Optional<Bullet>) {
    print("do nothing")
}
//: ### 定义参数是Array，范型类型指定为 Bullet
func test(bullet: Array<Bullet>) {
    print("do nothing")
}
//: ### 定义参数是Set，范型类型指定为 Bullet
func test(bullet: Set<Bullet>) {
    print("do nothing")
}

//: ### 定义参数是BulletContainer，范型类型指定为 Bullet
func test(bullet: BulletContainer<Bullet>) {
    print("do nothing")
}

let bullet = Bullet(type: "type-A", speed: 100)
let subBullet = SubBullet(type: "sub-type-A", speed: 150)

test(bullet: bullet)
test(bullet: subBullet)

test(bullet: [bullet])
test(bullet: [subBullet])

test(bullet: Set.init([bullet]))
test(bullet: Set.init([subBullet]))

let container1 = BulletContainer<Bullet>()
let container2 = BulletContainer<SubBullet>()

test(bullet: container1)

//: ### 和Swift内置类型是不一样, 自定义的BulletContainer无法自动转换其[范型类型]为【子类类型】。Swift内置的 Optional-Array-Set 中的元素类型[范型类型]，可以为类的子类。
// Cannot convert value of type 'BulletContainer<SubBullet>' to expected argument type 'BulletContainer<Bullet>'
// test(bullet: container2)


//: ### 如下的定义是可以的避免上述的编译错误
//: ### 定义参数是BulletContainer，范型类型指定为 Bullet 或其子类
func testEx<T: Bullet>(bullet: BulletContainer<T>) {
    print("do nothing")
}
testEx(bullet: container1)
testEx(bullet: container2)

//: [目录](目录) - [Previous page](@previous) - [Next page](@next)

