//: [目录](目录) - [Previous page](@previous) - [Next page](@next)

import Foundation

//: # 协议关联类型的检查
//: ## Type属性的使用以及 检查

//: ##  首先理解：String，String.Type, String.Type.self , String.Type.Type 之间的关系。

let name: String = "丰源天下"
print(name)
print(type(of: name))
print("--------------------------------------")
let nameType = String.self
print(nameType)
print(type(of: nameType))
print("--------------------------------------")
let typeOfNameType = String.Type.self
print(typeOfNameType)
print(type(of: typeOfNameType))

//: ## name             ----> Sting
//: ## Sting.self       ----> String.Type
//: ## String.Type.self ----> String.Type.Type

//: ## 任务来自外部，我们该如何设计呢？
//: ## 设想，如果知道军队中狼人的 工作输入和输出类型，把适合的任务给指定的狼人就可以了。

protocol MonsterProtocol {
    associatedtype Input
    associatedtype Output
    var name: String { get }
    var ranking: Int { get set}
    var desc: String? { get set}
    init(name: String)
    func runAction() -> Void
    func doWork(input: Input) -> Output
}

// 遵守了（实现了）狼人协议
struct MonsterWolf_1 : MonsterProtocol {
    // 使用 typealias 进行 协议关联类型的指定。
    typealias Input = String
    typealias Output = Bool
    
    var name: String
    var ranking: Int
    var desc: String?
    
    init(name: String) {
        self.name = name
        self.ranking = 15
        self.desc = "我是一只武装的怪兽-狼人"
    }
    
    func runAction() {
        print("\(self.name) run action")
    }
    
    func doWork(input: String) -> Bool {
        print("狼人接受了一个工作，输入是 字符，输出是 布尔")
        return true
    }
    
}

// 遵守了（实现了）狼人协议
struct MonsterWolf_2 : MonsterProtocol {
    
    // 使用 typealias 进行 协议关联类型的指定。
    typealias Input = Int
    typealias Output = Double
    
    var name: String
    var ranking: Int
    var desc: String?
    
    init(name: String) {
        self.name = name
        self.ranking = 15
        self.desc = "我是一只武装的怪兽-狼人"
    }
    
    func runAction() {
        print("\(self.name) run action")
    }
    
    
    func doWork(input: Int) -> Double {
        print("狼人接受了一个工作，输入是 Int，输出是 Double")
        return Double.init(input)
    }
}
 
// 类型擦除的设计方法
struct AnyMonsterWolf: MonsterProtocol {
  
    var name: String
    var ranking: Int
    var desc: String?
    
    private var wrappedRunAction: (() -> Void)?
    private var wrappedDoWork: ((_ input: Any) -> Any)?
    
    var acceptData: (Any,Any)?
    
    init(name: String) {
        self.name = name
        self.ranking = 15
        self.desc = "我是一只武装的怪兽-狼人"
    }
    
    init<T: MonsterProtocol>(_ monster: T) {
      name = monster.name
      ranking = monster.ranking
      desc = monster.desc
      wrappedRunAction = monster.runAction
      // 保持接受任务的类型
      let inputType = T.Input.self
      // let inputType = T.Input.Type.self
      let outputType = T.Output.self
      // let outputType = T.Output.Type.self
        
      acceptData = (inputType, outputType)
      
      wrappedDoWork = { inputParam in
                        guard let model = inputParam as? T.Input else {
                            return "Wrong Result" as Any
                        }
                        return monster.doWork(input: model)
                    }
   }
    
   func runAction() {
      self.wrappedRunAction?()
   }
    
   func doWork(input: Any) -> Any {
      return wrappedDoWork!(input)
   }
    
}

extension MonsterProtocol {
    func asAnyMonsterWolf() -> AnyMonsterWolf {
        AnyMonsterWolf(self)
    }
}


struct MonsterArmy {

    var monsters : [AnyMonsterWolf] = []

    init() {}

    init(monsters: [AnyMonsterWolf]) {
        self.monsters = monsters
    }

    mutating func addMonster(monster: AnyMonsterWolf) {
        self.monsters.append(monster)
    }
    
    func doWork() {
        monsters.forEach {
            switch $0.name {
                case "狼人1号":
                    let result = $0.doWork(input: "请检查仓库")
                    print(result as! Bool)
                case "狼人2号":
                    let result = $0.doWork(input: 100)
                    print(result as! Double)
                default:
                    print("wrong type")
            }
        }
    }
    
    
    /// 根据参数和结果的类型，找到指定的狼人，进行完成任务
    /// - Parameter taskInfo: （输入类型， 输出类型，参数）
    /// - Returns: 结果
    func doSpecializedTask(taskInfo: (i: Any, o: Any , param: Any)) -> Any? {
        for monster in monsters {
            if let acceptData = monster.acceptData {
                if type(of: taskInfo.i) == type(of: acceptData.0) &&
                    type(of: taskInfo.o) == type(of: acceptData.1) {
                    print("已经接受任务")
                    let result = monster.doWork(input: taskInfo.param)
                    return result
                }
            }
        }
        return nil
    }
}


let monsters : [AnyMonsterWolf] = [ MonsterWolf_1(name: "狼人1号").asAnyMonsterWolf() , MonsterWolf_2(name: "狼人2号").asAnyMonsterWolf()]
var monsterArmy = MonsterArmy(monsters: monsters)

monsterArmy.doWork()


let task = (i: String.self, o: Bool.self, "这是一个特殊的任务")
if let result = monsterArmy.doSpecializedTask(taskInfo: task) {
    print(result as! Bool)
} else {
    print("任务接受失败")
}


let task2 = (i: Int.self, o: Double.self, 100)
if let result = monsterArmy.doSpecializedTask(taskInfo: task2) {
    print(result as! Double)
} else {
    print("任务接受失败")
}
//: ### 这是一个失败的任务发送！！
let task3 = (i: Float.self, o: Float.self, 300.00)
if let result = monsterArmy.doSpecializedTask(taskInfo: task3) {
    print(result as! Float)
} else {
    print("任务接受失败")
}

//: [目录](目录) - [Previous page](@previous) - [Next page](@next)
