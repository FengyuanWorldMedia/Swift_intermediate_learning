//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)

//: # 保持异常前状态-Undo - ver2 使用异常进行

import Foundation

typealias ACTION = (MonsterWolf) throws -> Void
typealias RECOVERY = (MonsterWolf) -> Void

enum WolfManActionError: Error {
    case flyError
    case climbError
}

//: ## 怪兽狼人有各种技能
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
    
    var actionList = [(action: ACTION, recovery: RECOVERY)]()
    
    /// 分析为何不产生 循环引用
    deinit {
        print("Game over")
    }
    
    func status() {
        print("ranking:\(ranking), point:\(magicPoint)")
    }
    
}

var monsterWolf1: MonsterWolf? = MonsterWolf(name: "怪兽狼人1号", ranking: 8, magicPoint: 200, desc: "就在今晚行动")
 

var flyAction: (action: ACTION, recovery: RECOVERY) = (action:
                                                        { monster in
                                                            monster.ranking += 2
                                                            monster.magicPoint -= 15
                                                            let flyStatus = Bool.random()
                                                            if flyStatus {
                                                                print("Fly action ok")
                                                            } else {
                                                                print("Fly action ng")
                                                                throw WolfManActionError.flyError
                                                            }
                                                        },
                                                       recovery: { monster in
                                                            monster.ranking -= 2
                                                        })

var climbAction: (action: ACTION, recovery: RECOVERY) = (action:
                                                        { monster in
                                                            monster.ranking += 1
                                                            monster.magicPoint -= 10
                                                            let climbStatus = Bool.random()
                                                            if climbStatus {
                                                                print("Climb action ok")
                                                            } else {
                                                                print("Climb action ng")
                                                                throw WolfManActionError.climbError
                                                            }
                                                        },
                                                       recovery: { monster in
                                                            monster.ranking -= 1
                                                        })


monsterWolf1?.actionList.append(flyAction)
monsterWolf1?.actionList.append(climbAction)
print("初始状态:")
monsterWolf1?.status()
print("\n")

if let actionList = monsterWolf1?.actionList {
    for actionInfo in actionList {
        monsterWolf1!.status()
        do {
            try actionInfo.action(monsterWolf1!)
        } catch {
            actionInfo.recovery(monsterWolf1!)
        }
        monsterWolf1!.status()
        print("\n\n")
    }
}

monsterWolf1 = nil


//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)
