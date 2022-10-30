//: [目录](目录) - [Previous page](@previous) - [Next page](@next)

import Foundation

//: # 协议关联类型的约束
 
//: ## 现在的任务消化都是由【狼人🐺军队】，内部协调。
//: ## 为满足，单独狼人 或 特别单独任务的执行，我们需要为【狼人🐺军队】增加方法。 学习 使用where句对 范型的关联类型进行约束。

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

// 遵循了狼人协议
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

// 遵守了（实现了）狼人协议
struct MonsterWolf_3 : MonsterProtocol {
    
    // 使用 typealias 进行 协议关联类型的指定。
    typealias Input = String
    typealias Output = String
    
    var name: String
    var ranking: Int
    var desc: String?
    
    init(name: String) {
        self.name = name
        self.ranking = 15
        self.desc = "我是一只武装的怪兽-狼人-飞行员"
    }
    
    func runAction() {
        print("\(self.name) run action")
    }
    
    func doWork(input: String) -> String {
        print("狼人接受了一个工作，输入是 String，输出是 String")
        return input
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
    
//: ## 增加方法，让任务执行为指定的狼人。
    /// 方法不要求工作内容由军队协调完成，而是由指定的狼人对象完成，完成后 返回结果。 注意这里 不使用【AnyMonsterWolf】，更灵活了。
    /// - Parameters:
    ///   - wolf: 指定狼人
    ///   - taskInput: 任务输入
    /// - Returns: 任务结果
    static func doWolfManTask<T: MonsterProtocol>(wolf: T, taskInput: T.Input) -> T.Output {
        print("狼人：\(wolf.name), 任务执行，得到军队的许可")
        let result = wolf.doWork(input: taskInput)
        print("狼人：\(wolf.name), 任务执行结束，返回执行结果")
        return result
    }
//: ## 使用where进行 协议关联类型约束。
    /// 方法不要求工作内容由军队协调完成，而是由指定的狼人对象完成，完成后 返回结果。 where约束，要求 只有 输入和输出都是String 的狼人工作内容，才能使用 doWolfManTaskEx 方法。
    /// - Parameters:
    ///   - wolf: 指定狼人
    ///   - taskInput: 任务输入
    /// - Returns: 任务结果
    static func doWolfManTaskEx<T: MonsterProtocol>(wolf: T, taskInput: T.Input) -> T.Output where T.Input == String , T.Output == String {
        print("勋章任务： 狼人：\(wolf.name), 任务[✈️飞行驾驶]执行，得到军队的许可")
        let result = wolf.doWork(input: taskInput)
        print("勋章任务： \(wolf.name), 任务执行[✈️飞行驾驶]结束，返回执行结果")
        return result
    }
}


let monster1 = MonsterWolf_1(name: "狼人1号")
let result1 = MonsterArmy.doWolfManTask(wolf: monster1, taskInput: "这是一个特殊的任务")
print(result1)

print("\n\n")
let monster2 = MonsterWolf_2(name: "狼人2号")
let result2 = MonsterArmy.doWolfManTask(wolf: monster2, taskInput: 500)
print(result2)
print("\n\n")

let monster3 = MonsterWolf_3(name: "狼人3号")
let result3 = MonsterArmy.doWolfManTask(wolf: monster3, taskInput: "飞行任务")
print(result3)
print("\n\n")

//: ## 由于，协议关联类型的约束；狼人1号和狼人2号 都执行不了 【勋章任务】。
//let result4 = MonsterArmy.doWolfManTaskEx(wolf: result2, taskInput: "飞行任务")
//let result4 = MonsterArmy.doWolfManTaskEx(wolf: result1, taskInput: "飞行任务")

let result4 = MonsterArmy.doWolfManTaskEx(wolf: monster3, taskInput: "飞行任务")
print(result4)

//: [目录](目录) - [Previous page](@previous) - [Next page](@next)
