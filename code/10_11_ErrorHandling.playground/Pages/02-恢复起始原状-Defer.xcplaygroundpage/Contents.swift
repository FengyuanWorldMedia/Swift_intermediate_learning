//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)

//: # 02-恢复起始原状-Defer
//: ## 使用Defer语句，回复异常前的状态。


import Foundation

enum WolfManActionError: Error {
    case flyError
}

//: ## 怪兽狼人有飞行能力
class MonsterWolf {
    var name: String
    var ranking: Int
    var desc: String?
    var magicPoint: Int
    
    init(name: String, ranking: Int, magicPoint: Int, desc: String? = nil) {
        self.name = name
        self.ranking = ranking
        self.magicPoint = magicPoint
        self.desc = desc
    }
    
    func flyAction() {
        var flyFlag = false
        defer {
           if !flyFlag {
               ranking -= 1
           }
       }
        
        do {
            flyFlag = try fly()
        } catch WolfManActionError.flyError {
            print("必杀技飞行 失败 flyError")
        } catch {
            print("必杀技飞行 失败，Unknow Exception")
        }
    }
    
    private func fly() throws -> Bool {
        ranking += 1
        magicPoint -= 20
        
        if Bool.random() {
            throw WolfManActionError.flyError
        }
        print("MonsterWolf name:\(self.name) fly action")
        return true
    }
    
    func status() {
        print("ranking:\(ranking), point:\(magicPoint)")
    }
    
}

var monsterWolf1 = MonsterWolf(name: "怪兽狼人1号", ranking: 8, magicPoint: 200, desc: "就在今晚行动")

monsterWolf1.status()

monsterWolf1.flyAction()
monsterWolf1.status()


//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)
