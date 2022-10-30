//: [回到目录](目录) - [Previous page](@previous)

//: # 统一异常处理
//: ## 统一异常处理的意义在于: 可以结构化，系统化地 处理异常。

import Foundation


//: ## 统一处理异常前，对异常进行 ！！“正规化”！！
enum WolfManFightError: Error {
    case lowRanking(Int)  // 级别不够
    case actionFail(String)  // 失败
}

//: ### 实现LocalizedError协议

extension WolfManFightError : LocalizedError {
    /// A localized message describing what error occurred.
    public var errorDescription: String? {
        switch self {
            case .lowRanking(let rankingNo):
                return "级别太低， 当前级别:\(rankingNo)"
            case .actionFail(let actionName):
                return "动作执行失败， 动作名称:\(actionName)"
        }
    }

    /// A localized message describing the reason for the failure.
    public var failureReason: String? {
        switch self {
            case .lowRanking(_):
                return "级别太低"
            case .actionFail(_):
                return "动作执行失败"
        }
    }

    /// A localized message describing how one might recover from the failure.
    public var recoverySuggestion: String? {
        switch self {
            case .lowRanking(_):
                return "按住Ctrl键+左击鼠标，进行充值"
            case .actionFail(_):
                return "按住Ctrl键+右击鼠标，返回到之前的位置"
        }
    }

    /// A localized message providing "help" text if the user requests help.
    public var helpAnchor: String? {
        switch self {
            case .lowRanking(_):
                return "参考我们的官网： https://gamecenter-charge.fytx.com"
            case .actionFail(_):
                return "参考我们的官网： https://gamecenter-manual.fytx.com"
        }
    }
}

//: ### 实现CustomNSError协议
extension WolfManFightError: CustomNSError {
    
    /// Default domain of the error.
    public static var errorDomain: String {
        "gamecenter.fytx.com"
    }

    /// The error code within the given domain.
    public var errorCode: Int {
        switch self {
        case .lowRanking(_):
            return 9956
        case .actionFail(_):
            return 9957
        }
    }

    /// The default user-info dictionary.
    public var errorUserInfo: [String : Any] {
        [
            NSLocalizedDescriptionKey: errorDescription ?? "",
            NSLocalizedFailureReasonErrorKey: failureReason ?? "",
            NSLocalizedRecoverySuggestionErrorKey: recoverySuggestion ?? "",
        ]
    }
}

//: ### 实现异常的 统一处理类
class ErrorProcessor {
    
    static let `default` = ErrorProcessor()
    
    func handlerError(_ error: LocalizedError & CustomNSError) {
       
        if let errDesc = error.errorDescription {
           print("Error Description: \(errDesc)")
       } else {
           print("No errorDescription, check the code, please!")
       }
       
       let nsError = error as NSError
       print(nsError.domain)
       print(nsError.code)
       print(nsError.userInfo)
    }
}



// 升级的怪兽狼人-父类-有必杀技技能(级别够的话，一定可以赢)
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
        other.point = 0
        other.ranking = 0
        other.desc = "被无情地消灭了"
        return true
    }
}

// 一个怪兽狼人和另外一个怪兽狼人战斗
class MonsterWolfSubClass : MonsterWolf {
     
    var name: String
    var ranking: Int
    var desc: String?
    var point: Int
    
    init(name: String, ranking: Int, point: Int, desc: String? = nil) {
        self.name = name
        self.ranking = ranking
        self.point = point
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
            self.point += 50
        } catch let err as LocalizedError & CustomNSError {
//: ### 异常的统一处理
            ErrorProcessor.default.handlerError(err)
            self.point -= 50
        } catch {
            fatalError("不可预知的错误。请检查您代码 或者 上报此错误信息。")
        }
    }
    
    func status() {
        print("name:\(self.name),ranking:\(ranking), point:\(point), desc:\(self.desc ?? "no desc")")
    }
}


var monsterWolf1 = MonsterWolfSubClass(name: "怪兽狼人1号", ranking: 10, point: 200, desc: "就在今晚行动")
var monsterWolf2 = MonsterWolfSubClass(name: "怪兽狼人2号", ranking: 8, point: 200, desc: "就在今晚阻击对方行动")
 
monsterWolf1.status()
monsterWolf1.killWolfMan(enemy: monsterWolf2)
monsterWolf1.status()

monsterWolf2.status()


//: [回到目录](目录) - [Previous page](@previous)



