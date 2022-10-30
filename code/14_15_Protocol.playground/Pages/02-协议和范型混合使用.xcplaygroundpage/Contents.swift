//: [目录](目录) - [Previous page](@previous) - [Next page](@next)

import Foundation


//: # 协议和范型混合使用
//: ## 在协议中定义 范型

//: ## 狼人协议要求 狼人 需要做一定的工作，工作有输入Input内容，和输出Output内容。
//: ## 但是，每种狼人的输入和输出都可能不一样。很自然，就会想到范型去定义。

//: ### 尴尬的是，协议不支持范型的定义。
//: ### Protocols do not allow generic parameters; use associated types instead
    //protocol MonsterProtocolEx<T> {
    //    var name: String { get }
    //    var ranking: Int { get set}
    //    var desc: String? { get set}
    //    init(name: String)
    //    func runAction() -> Void
    //}

//: ### 使用关联类型 associated types 进行 工作的 输入和输出定义。
//: ### 我们可以认为，关联类型就是协议中 范型的一种定义方法。
protocol MonsterProtocol {
    
    associatedtype Input
    associatedtype Output

    var name: String { get }
    var ranking: Int { get set}
    var desc: String? { get set}
    init(name: String)
    func runAction() -> Void
    func doWork(input: Input) -> Output // 注意这里的定义
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

//: ## 加入关联类型后，会得到以下错误。
//: ## Protocol 'MonsterProtocol' can only be used as a generic constraint because it has Self or associated type requirements
//struct MonsterArmy {
//
//    var monsters: Array<MonsterProtocol> = []
//
//    init() {}
//
//    init(monsters: Array<MonsterProtocol>) {
//        self.monsters = monsters
//    }
//
//    mutating func addMonster(monster: MonsterProtocol) {
//        self.monsters.append(monster)
//    }
//}


//: ## 还记得如何设计吗？ 使用类型擦除的设计方法。
//: ## 带有关联类型的，类型擦除定义方法。
//: ## AnyMonsterWolf 对象的wrappedDoWork要融合所有的参数类型，所以定义为Any.
//: ## 在对wrappedDoWork设值的时候，使用 类型判定是否和 T.Input相等
struct AnyMonsterWolf: MonsterProtocol {
  
    var name: String
    var ranking: Int
    var desc: String?
    
    private var wrappedRunAction: (() -> Void)?
    private var wrappedDoWork: ((_ input: Any) -> Any)?
    
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
}


let monsters : [AnyMonsterWolf] = [ MonsterWolf_1(name: "狼人1号").asAnyMonsterWolf() , MonsterWolf_2(name: "狼人2号").asAnyMonsterWolf()]
var monsterArmy = MonsterArmy(monsters: monsters)

//: ## 可以看出，【🐺狼人军队】在开始工作，就调用了军队里的每个成员进行工作。工作内容由，内部产生。
//: ## 如果，任务来自外部，我们该如何设计呢？
monsterArmy.doWork()

//: [目录](目录) - [Previous page](@previous) - [Next page](@next)
