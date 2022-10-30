//: [目录](目录) - [Previous page](@previous) - [Next page](@next)

import Foundation

//: # 扩展Built-in数据类型（数组）

protocol MonsterProtocol {
    var name: String { get }
    var ranking: Int { get set}
    var desc: String? { get set}
    init(name: String)
    func runAction() -> Void
}

class MonsterWolfMan: MonsterProtocol {
    var name: String
    var ranking: Int
    var desc: String?
    
    required init(name: String) {
        self.name = name
        self.ranking = 15
        self.desc = "我是的怪兽-狼人1号"
    }
    
    func runAction() {
        print("MonsterWolfMan --> runAction ")
    }
    
}


class MonsterWolfManArmy<T: MonsterProtocol> {
    
    private var members: [T] = []
    
    func addWolfMan(wolf: T) {
        members.append(wolf)
    }
    
    /// 找到相同名字的 狼人
    /// - Returns: （名字，狼人列表）
    func findWolves() -> [String : [T]] {
        var result = [String: [T]]()
        for e in members {
            let name = e.name
            let sameWolves = members.filter({ $0.name == name })
            if sameWolves.count > 1 && !result.keys.contains(name) {
                result[name] = sameWolves
            }
        }
        return result
    }
    
    func getMembers() -> [T] {
        return self.members
    }
}


let army = MonsterWolfManArmy<MonsterWolfMan>()
army.addWolfMan(wolf: MonsterWolfMan(name: "狼人1号"))
army.addWolfMan(wolf: MonsterWolfMan(name: "狼人1号"))
army.addWolfMan(wolf: MonsterWolfMan(name: "狼人3号"))
army.addWolfMan(wolf: MonsterWolfMan(name: "狼人4号"))
army.addWolfMan(wolf: MonsterWolfMan(name: "狼人4号"))


let sameWolves = army.findWolves()

for e in sameWolves {
    print(e.0)
    print(e.1)
    print("\n")
}

print("--------------------------------------------------------------------------------")

//: ## 扩展Array，如果其元素为 MonsterProtocol ， 则可以使用 findSameWolves 方法找出 重名的 狼人。
//: ## 注意where句的约束条件的写法。
//: ## 在扩展方法findSameWolves体里的self 为 数组本身。
extension Array where Element: MonsterProtocol {
    
    func findSameWolves() -> [String : [Element]] {
        var result = [String: [Element]]()
        for e in self {
            let name = e.name
            let sameWolves = self.filter({ $0.name == name })
            if sameWolves.count > 1 && !result.keys.contains(name) {
                result[name] = sameWolves
            }
        }
        return result
    }
    
}

let sameWolves1 = army.getMembers().findSameWolves()

for e in sameWolves1 {
    print(e.0)
    print(e.1)
    print("\n")
}

//: [目录](目录) - [Previous page](@previous) - [Next page](@next)
