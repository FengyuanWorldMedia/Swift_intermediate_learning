//: [目录](目录) - [Previous page](@previous)

import Foundation

//: # 娱乐时间-模拟狼人斗枪
//: ## 两个狼人相互开枪，魔法值先用完的一方为失败者。

extension Array {
    func mapToSet<T: Hashable>(_ transform: (Element) -> T) -> Set<T> {
        var result = Set<T>()
        for item in self {
            result.insert(transform(item))
        }
        return result
    }
}

//: ### 定义子弹类型
struct Bullet: Hashable, Comparable {
    var type: String
    var speed: Int
    
    static func < (lhs: Bullet, rhs: Bullet) -> Bool {
        return lhs.speed < rhs.speed
    }
    
    static func == (lhs: Bullet, rhs: Bullet) -> Bool {
        return lhs.speed == rhs.speed
    }
}

//: ### 扩展子弹，获取其信息
extension Bullet: CustomDebugStringConvertible, CustomStringConvertible {
    
    var description: String {
        return "Log:: 子弹类型\(type), 子弹速度:\(speed)"
    }
    
    var debugDescription: String {
        return "Debug Log:: - 子弹类型\(type), 子弹速度:\(speed)"
    }
}

//: ### 定义Log
typealias LOG_OBJECT = CustomStringConvertible & CustomDebugStringConvertible
struct Logger {
    
    var debugMode: Bool = false
    
    func log<T>(obj: T?) where T: LOG_OBJECT {
        if let logObj = obj {
            if debugMode {
                print(logObj.debugDescription)
            } else {
                print(logObj.description)
            }
        } else {
            print("Nothing")
        }
    }
}


//: ### 增加范型的约束，使其可以直接打印Log信息.
struct BulletContainer<B: Comparable & Hashable & LOG_OBJECT> {
    
    private let logger = Logger()
    
    private var bulletDic: Dictionary<String , B> = [:]
    
    mutating func addBullet(key: String , bullet: B) {
        // logger.log(obj: bullet)
        self.bulletDic[key] = bullet
    }
    
    mutating func popBullet() -> B? {
        let bullet = self.bulletDic.popFirst()
        logger.log(obj: bullet?.value)
        return bullet?.value
    }
}


class MonsterWolf {
    // 互斥锁，必须等锁释放后才能再次获取锁
    // 防止两条线程同时对同一公共资源进行读写的机制
    private var stateLock = NSLock()
    var name: String
    var ranking: Int
    private var magicPoint: Int
    var desc: String?
    
    var bulletContainer = BulletContainer<Bullet>()
    
    init(name: String) {
        self.name = name
        self.ranking = 15
        self.magicPoint = 100
        self.desc = "我是一只武装的怪兽-狼人"
        for i in 1...100 {
            bulletContainer.addBullet(key: "第\(i)发子弹", bullet: Bullet(type: "A-\(i)", speed: 17))
        }
    }
    
    func shoot() -> Bullet? {
        return bulletContainer.popBullet()
    }
    
    func addMagicPoint(point: Int) {
        stateLock.lock()
        magicPoint += point
        stateLock.unlock()
    }
    
    func getMagicPoint() -> Int {
        stateLock.lock()
        let result = self.magicPoint
        stateLock.unlock()
        return result
    }
}

//: ### 模拟枪斗舞台
class Stage {
    
    private static func probabilityOK(_ actionFinished: Float) -> Bool {
        assert(actionFinished >= 0 && actionFinished <= 1.0, "错误的动作完成概率输入")
        let random = Float.random(in: 0...1)
        return random < actionFinished
    }
    
    static func fight(wolfMan1: MonsterWolf , wolfMan2: MonsterWolf , winning: Float) {
        assert(winning >= 0 && winning <= 1.0, "错误的胜率输入")
        
        // 狼人1对狼人2 的 枪弹射击🔫
        DispatchQueue.global(qos: .userInteractive).async {
            while true {
                sleep(2)
                if probabilityOK(winning) {
                    if let _ = wolfMan1.shoot() {
                        wolfMan1.addMagicPoint(point: 1)
                        print("狼人2号， 被击中一枪")
                        wolfMan2.addMagicPoint(point: -1)
                        if wolfMan2.getMagicPoint() == 0 {
                            print("狼人2号，很可惜，失败了。")
                            break
                        }
                    } else {
                        print("狼人1号，已经没有子弹")
                        break
                    }
                } else {
                    print("狼人1号， 失去开枪机会。。。")
                }
            }
        }
        // 狼人2对狼人1 的 枪弹射击🔫
        DispatchQueue.global(qos: .userInteractive).async {
            while true {
                sleep(2)
                if probabilityOK(winning) {
                    if let _ = wolfMan2.shoot() {
                        wolfMan2.addMagicPoint(point: 1)
                        print("狼人1号， 被击中一枪")
                        wolfMan1.addMagicPoint(point: -1)
                        if wolfMan1.getMagicPoint() == 0 {
                            print("狼人1号，很可惜，失败了。")
                            break
                        }
                    } else {
                        print("狼人2号，已经没有子弹")
                        break
                    }
                } else {
                    print("狼人2号， 失去开枪机会。。。")
                }
            }
        }
    }
    
}

let wolfMan1 = MonsterWolf(name: "狼人1号")
let wolfMan2 = MonsterWolf(name: "狼人2号")
Stage.fight(wolfMan1: wolfMan1, wolfMan2: wolfMan2, winning: 0.15)

//: [目录](目录) - [Previous page](@previous)

