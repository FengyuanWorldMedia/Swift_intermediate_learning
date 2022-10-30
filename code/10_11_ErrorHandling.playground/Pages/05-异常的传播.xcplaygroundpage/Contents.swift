//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)

//: # 异常的传播

import Foundation

//: ## 升级的怪兽狼人-父类-有必杀技技能(级别够的话，一定可以赢)
class MonsterWolf {
  
    func check() throws -> Bool {
        try checkRanking()
        return true
    }
    
    func checkRanking() throws {
        fatalError("不可以在父类中使用 - 需要被子类重写 - checkRanking ")
    }
    
    func step1_run() throws {
        fatalError("不可以在父类中使用 - 需要被子类重写 - step1_run ")
    }
    
    func step2_bellow() throws {
        fatalError("不可以在父类中使用 - 需要被子类重写 - step2_bellow ")
    }
    
    func step3_kill() throws {
        fatalError("不可以在父类中使用 - 需要被子类重写 - step3_kill ")
    }
    
    func probabilityOK(_ actionFinished: Float) -> Bool {
        assert(actionFinished >= 0 && actionFinished <= 1.0, "错误的动作完成概率输入")
        let random = Float.random(in: 0...1)
        return random < actionFinished
    }
    
    ///  级别够的话，一定可以赢
    /// - Parameter other: 另外一个狼人
    /// - Returns: 是否打赢了
    final func fightAgainst(other: MonsterWolfSubClass) throws -> Bool {
        let checkResult = try check()
        if !checkResult {
            return false
        }
        try step1_run()
        try step2_bellow()
        try step3_kill()
        other.magicPoint = 0
        other.ranking = 0
        other.desc = "被无情地消灭了"
        return true
    }
}

//: ## 一个怪兽狼人和另外一个狼人战斗
enum WolfManFightError: Error {
    case lowRanking(Int)  // 级别不够
    case actionFail(String)  // 失败
}

class MonsterWolfSubClass: MonsterWolf {
     
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
    
    override func checkRanking() throws {
        if ranking < 10 {
            throw WolfManFightError.lowRanking(self.ranking)
        }
    }
    
    override func step1_run() throws {
        if !probabilityOK(0.5) {
            throw WolfManFightError.actionFail("Run Action Failed")
        }
        print("   1---> RUN")
    }
  
    override func step2_bellow() throws {
        if !probabilityOK(0.5) {
            throw WolfManFightError.actionFail("Bellow Action Failed")
        }
        print("   1---> BELLOW")
    }
    
    override func step3_kill() throws {
        if !probabilityOK(0.5) {
            throw WolfManFightError.actionFail("Kill Action Failed")
        }
        print("   1---> KILL")
    }
    
    func killWolfMan(enemy: MonsterWolfSubClass) {
        do {
            try fightAgainst(other: enemy)
            self.magicPoint += 50
        } catch WolfManFightError.lowRanking(let currRanking) {
            self.magicPoint -= 50
            print("    狼人:\(self.name), 级别不够，不能使用必杀技。当前级别:\(currRanking)")
        } catch WolfManFightError.actionFail(let actionName) {
            self.magicPoint -= 50
            print("    狼人:\(self.name), 使用必杀技，动作失败。失败动作:\(actionName)")
        } catch {
            self.magicPoint -= 50
            print("    狼人:\(self.name), 使用必杀技，失败，原因不明。")
        }
    }
    
    func status() {
        print("name:\(self.name),ranking:\(ranking), magicPoint:\(magicPoint), desc:\(self.desc ?? "no desc")")
    }
}


var monsterWolf1 = MonsterWolfSubClass(name: "怪兽狼人1号", ranking: 10, magicPoint: 200, desc: "就在今晚行动")
var monsterWolf2 = MonsterWolfSubClass(name: "怪兽狼人2号", ranking: 8, magicPoint: 200, desc: "就在今晚阻击对方行动")
 
monsterWolf1.status()
monsterWolf1.killWolfMan(enemy: monsterWolf2)
monsterWolf1.status()

monsterWolf2.status()

print("------------------------------------------------------------------------------------")

var monsterWolf3 = MonsterWolfSubClass(name: "怪兽狼人3号", ranking: 5, magicPoint: 200, desc: "就在今晚行动")
var monsterWolf4 = MonsterWolfSubClass(name: "怪兽狼人4号", ranking: 15, magicPoint: 200, desc: "就在今晚阻击对方行动")

monsterWolf3.status()
monsterWolf3.killWolfMan(enemy: monsterWolf4)
monsterWolf3.status()

monsterWolf4.status()


//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)
