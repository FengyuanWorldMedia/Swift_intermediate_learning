//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)

//: # Error协议
import Foundation

//: ## Error协议的定义
//: ### protocol Error : Sendable
//: ### Error协议，不要求实现任何方法，象征性地实现就可以了。
//: ### Sendable协议表示：告诉编译器：一种类型，其值可以通过复制安全地跨并发线程之间 传递。

enum WolfManActionError: Error {
    case rankingError
    case nameSizeError(String)
    case noDescError
}

class MonsterWolf {
    var name: String
    var ranking: Int
    var desc: String?
    
    init(name: String, ranking: Int, desc: String? = nil) {
        self.name = name
        self.ranking = ranking
        self.desc = desc
    }
    
    func killAction() {
        do {
            try kill()
        } catch WolfManActionError.rankingError {
            print("必杀技不能使用，级别太低")
        } catch WolfManActionError.noDescError {
            print("必杀技不能使用，描述不对")
        } catch WolfManActionError.nameSizeError(let name) {
            print("必杀技不能使用，名号太短了，名号:\(name)")
        } catch {
            print("必杀技不能使用，Unknow Exception")
        }
    }
    
    private func kill() throws {
        if self.ranking < 10 {
            throw WolfManActionError.rankingError
        }
        if self.name.lengthOfBytes(using: .utf8) < 10 {
            throw WolfManActionError.nameSizeError(self.name)
        }
        if let desc = self.desc, desc.isEmpty {
            throw WolfManActionError.noDescError
        }
        print("MonsterWolf name:\(self.name) kill action")
    }
}

var monsterWolf1 = MonsterWolf(name: "怪兽狼人1号", ranking: 8, desc: "就在今晚行动")
var monsterWolf2 = MonsterWolf(name: "狼人", ranking: 15, desc: "就在今晚行动")
var monsterWolf3 = MonsterWolf(name: "怪兽狼人3号", ranking: 11 , desc: "")
monsterWolf1.killAction()
monsterWolf2.killAction()
monsterWolf3.killAction()
print("")
print("")
print("")

//: ### 使用结构体实现Error协议
//: ### 缺点比较明显，类型比较单一。如果是统一处理的情况下，可以考虑使用。
struct WolfManRunActionError: Error {
    let name: String
    let desc: String
}

extension MonsterWolf {
    
    func runAction() {
        do {
            try run()
        } catch let runActionError as WolfManRunActionError {
            print("runActionError : name:\(runActionError.name), desc: \(runActionError.desc)")
        } catch {
            print("必杀技不能使用，Unknow Exception")
        }
    }
    
    private func run() throws {
        if self.name.lengthOfBytes(using: .utf8) < 10 {
            throw WolfManRunActionError(name: self.name, desc: self.desc ?? "没有描述")
        }
        if self.desc == nil {
            throw WolfManRunActionError(name: self.name, desc: self.desc ?? "没有描述")
        }
        print("MonsterWolf name:\(self.name) run action")
    }
    
}

var monsterWolf4 = MonsterWolf(name: "怪兽", ranking: 11 , desc: "今晚行动")
monsterWolf4.runAction()
var monsterWolf5 = MonsterWolf(name: "怪兽狼人5号", ranking: 13)
monsterWolf5.runAction()


//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)
