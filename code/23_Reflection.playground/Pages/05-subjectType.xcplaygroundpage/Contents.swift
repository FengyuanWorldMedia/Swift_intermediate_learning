//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)

//: # subjectType -- 获取Enum，Struct和Class的名字

import Foundation

//: ## 准备 Enum，Struct 和 Class定义
enum FightStatusEnum {
    case Fighting
    case Fighted
}

class MonsterClass {
    var name: String
    var ranking: Int
    var desc: String?
    
    init(name: String, ranking: Int, desc: String?) {
        self.name = name
        self.ranking = ranking
        self.desc = desc
    }
}

struct MonsterStruct {
    var name: String
    var ranking: Int
    var desc: String?
}


//: ## GetTypeProtocol 协议定义，可以保证 对象类型 和对象都可以 获取到 类型
protocol GetTypeProtocol {
    static var typeName: String { get }
    var typeName: String { get }
}

//: ## 实现 GetTypeProtocol（使用 subjectType）
//: ### 注意理解 self 的 使用。
//: ### self在 static 计算属性或 方法中，代表 GetTypeProtocol.self
//: ### self在 对象 计算属性或 方法中，代表 GetTypeProtocol 实例
extension GetTypeProtocol {
    static var typeName: String {
        return "\(Mirror(reflecting: self).subjectType)".components(separatedBy: ".")[0]
    }
    var typeName: String {
        return "\(Mirror(reflecting: self).subjectType)"
    }
}

extension FightStatusEnum: GetTypeProtocol { }

extension MonsterClass: GetTypeProtocol { }

extension MonsterStruct: GetTypeProtocol { }

print("---Enum--------------------------------------------------")
let fighting = FightStatusEnum.Fighting
print(fighting.typeName)

print(FightStatusEnum.typeName)

print("----struct-------------------------------------------------")
let monster = MonsterStruct(name: "狼人1号", ranking: 10)
print(monster.typeName)

print(MonsterStruct.typeName)

print("-----class------------------------------------------------")
let monster2 = MonsterClass(name: "狼人1号", ranking: 10, desc: "MonsterClass instance")
print(monster2.typeName)

print(MonsterClass.typeName)


//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)
