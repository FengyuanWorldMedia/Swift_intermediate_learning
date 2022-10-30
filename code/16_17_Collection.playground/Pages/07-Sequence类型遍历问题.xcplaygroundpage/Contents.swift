//: [目录](目录) - [Previous page](@previous) - [Next page](@next)

import Foundation

//: # Sequence类型遍历问题
//: ## 每次for-in 语句的结果不一样😅

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

//: ## army 是Sequence 对象，不是Collection 对象。
for e in army {
    if e.magicPoint == 35 {
        break
    }
    print(e.name)
}

//: ## 打印从哪里开始？ Sequence协议不保证，每次遍历的结果一样。 Collection 保证非破坏性的遍历，即每次遍历的结果都是一样的。
//: ## 多执行几次，就可以看到结果。😅
print("===========")
for e in army {
    print(e.name)
}

//: [目录](目录) - [Previous page](@previous) - [Next page](@next)
