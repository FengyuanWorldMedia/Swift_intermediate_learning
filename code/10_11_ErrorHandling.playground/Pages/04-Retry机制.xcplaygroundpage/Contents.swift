//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)

//: # Retry机制

import Foundation

//: ## 一个怪兽狼人和另外一个狼人战斗
enum WolfManFightError: Error {
    case fail // 失败
    case draw // 平局
}

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
    
    /// 和另外一个狼人决斗
    /// - Parameters:
    ///   - other: 狼人
    ///   - winning: 胜率
    func fightAgainstOneTime(other: MonsterWolf, winning: Float) {
        
        assert(winning >= 0 && winning <= 1.0, "错误的胜率输入")
        
        do {
            try fight(other: other, winning: winning)
        } catch WolfManFightError.fail {
            print("战斗失败, WolfManFightError.fail")
        } catch {
            print("战斗失败，Unknow Exception")
        }
    }
    
    private func fight(other: MonsterWolf, winning: Float) throws {
        let random = Float.random(in: 0...1)
        if random < winning {
            self.magicPoint += 1
            other.magicPoint -= 1
            print("狼人:\(self.name) VS 狼人:\(other.name)，赢了😊😊😊。得1分。")
        } else if random == winning {
            print("狼人:\(self.name) VS 狼人:\(other.name)，平局。😮‍💨😮‍💨😮‍💨")
            throw WolfManFightError.draw
        } else {
            print("狼人:\(self.name) VS 狼人:\(other.name)，输了战局😭😭😭。失1分。")
            self.magicPoint -= 1
            other.magicPoint += 1
            throw WolfManFightError.fail
        }
    }
    
    func status() {
        print("name:\(self.name),ranking:\(ranking), magicPoint:\(magicPoint)")
    }
    
}


var monsterWolf1 = MonsterWolf(name: "怪兽狼人1号", ranking: 10, magicPoint: 200, desc: "就在今晚行动")

var monsterWolf2 = MonsterWolf(name: "怪兽狼人2号", ranking: 8, magicPoint: 200, desc: "就在今晚阻击对方行动")

monsterWolf1.status()

monsterWolf1.fightAgainstOneTime(other: monsterWolf2, winning: 0.7)

monsterWolf1.status()

print("------------------------------------------------------------------------------------")

//: ## 一个怪兽狼人和另外一个狼人战斗 - 升级(允许多次尝试)
extension MonsterWolf {
    /// 和另外一个狼人决斗
    /// - Parameters:
    ///   - other: 狼人
    ///   - winning: 胜率
    ///   - times: 尝试次数
    func fightAgainst(other: MonsterWolf, winning: Float, times: Int) {
        
        assert(winning >= 0 && winning <= 1.0, "错误的胜率输入")
        assert(times >= 0 && times <= 5, "错误的尝试次数输入")
        
        var winFlag = false
        var retryTime = 1
        
        while times - retryTime >= 0 {
            do {
                try fight(other: other, winning: winning)
                winFlag = true
                break
            } catch WolfManFightError.fail {
                print("第\(retryTime)次,战斗失败")
            } catch {
                print("第\(retryTime)次,战斗失败")
            }
            retryTime += 1
            sleep(5)
        }
        
        if !winFlag {
            print("狼人:\(self.name) 尝试战斗 狼人:\(other.name) \(times)次，都失败了！")
        }
    }
}

var monsterWolf3 = MonsterWolf(name: "怪兽狼人3号", ranking: 10, magicPoint: 200, desc: "就在今晚行动")

var monsterWolf4 = MonsterWolf(name: "怪兽狼人4号", ranking: 8, magicPoint: 200, desc: "就在今晚阻击对方行动")

monsterWolf3.status()
monsterWolf3.fightAgainst(other: monsterWolf4, winning: 0.3, times: 5)
monsterWolf3.status()

print("\n")
monsterWolf4.status()
//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)
