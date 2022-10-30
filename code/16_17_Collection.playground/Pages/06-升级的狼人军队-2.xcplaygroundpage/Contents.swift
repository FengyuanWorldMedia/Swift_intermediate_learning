//: [目录](目录) - [Previous page](@previous) - [Next page](@next)

import Foundation

//: # 升级的狼人军队2

//: ## ArmyIterator --> AnyIterator
//: ## ExpressibleByArrayLiteral

struct WolfMan : Hashable {
    var name: String = ""
    var magicPoint: Int = 0
}

struct WolfArmy<T: Hashable> {
    private var members = [T: Int]()
    
    mutating func insert(_ element: T) {
        members[element, default: 0] += 1
    }
    
    mutating func remove(_ element: T) {
        members[element]? -= 1
        if members[element] == 0 {
            members[element] = nil
            members.removeValue(forKey: element)
        }
    }
    
    var count: Int {
        return members.values.reduce(0, +)
    }
}


extension WolfArmy: CustomStringConvertible {
    var description: String {
        var totalInfo = String()
        for (key, value) in members {
            totalInfo.append("\(key) 存在个数 \(value)\n")
        }
        return totalInfo
    }
}

//: ## 定义 【狼人军队迭代器】
//struct ArmyIterator<T: Hashable>: IteratorProtocol {
//    var members = [T: Int]()
//
//    mutating func next() -> T? {
//        guard let (key, value) = members.first  else {
//            return nil
//        }
//        if value > 1 {
//            members[key]? -= 1
//        } else {
//            members[key] = nil
//        }
//        return key
//    }
//}

//: ## 【狼人军队】也遵循Sequence协议, 解锁🔓 Sequence 的更多功能。
//extension WolfArmy: Sequence {
//    func makeIterator() -> ArmyIterator<T> {
//        return ArmyIterator(members: self.members)
//    }
//}

//: ## 定义 【狼人军队迭代器】 使用 AnyIterator
//: ### 这种替代，减少了代码量。
extension WolfArmy: Sequence {
    
    // 范性T 由 key 的返回值类型决定。
    func makeIterator() -> AnyIterator<T> {
        
        var allEles = members
        
        return AnyIterator<T> {
            guard let (key, value) = allEles.first  else {
                return nil
            }
            if value > 1 {
                allEles[key]? -= 1
            } else {
                allEles[key] = nil
            }
            return key
        }
    }
}



var army = WolfArmy<WolfMan>()
let wolfManNo1 = WolfMan(name: "1号", magicPoint: 25)
army.insert(wolfManNo1)
army.insert(wolfManNo1)

let wolfManNo2 = WolfMan(name: "2号", magicPoint: 100)
army.insert(wolfManNo2)

let wolfManNo3 = WolfMan(name: "3号", magicPoint: 35)
army.insert(wolfManNo3)
army.insert(wolfManNo3)
army.insert(wolfManNo3)

print(army.description)
// WolfMan(name: "2号", magicPoint: 100) 存在个数 1
// WolfMan(name: "1号", magicPoint: 25) 存在个数 2
// WolfMan(name: "3号", magicPoint: 35) 存在个数 3

for e in army {
    print(e.name)
}

let targetWolfMen = army.filter({$0.magicPoint < 40})
print(targetWolfMen)


//: ### ExpressibleByArrayLiteral

extension WolfArmy: ExpressibleByArrayLiteral {
    typealias ArrayLiteralElement = T
    init(arrayLiteral elements: T...) {
        members = elements.reduce(into: [T: Int]()) { (wolves, element) in
            wolves[element, default: 0] += 1
        }
    }
}

var army2 : WolfArmy<WolfMan> = [wolfManNo1, wolfManNo1, wolfManNo1,
                                 wolfManNo2,
                                 wolfManNo3, wolfManNo3, wolfManNo3]

print(army2.description)

//: [目录](目录) - [Previous page](@previous) - [Next page](@next)
