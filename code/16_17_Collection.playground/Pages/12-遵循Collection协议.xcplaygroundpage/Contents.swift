//: [目录](目录) - [Previous page](@previous)

import Foundation

//: # 遵循Collection协议

fileprivate func formatDate(d: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.calendar = Calendar(identifier: .gregorian)
    dateFormatter.locale = Locale(identifier: "zh_CN")
    dateFormatter.timeZone = TimeZone(identifier:  "Asia/Shanghai")
    dateFormatter.dateFormat = "yyyyMMdd"
    let dateString = dateFormatter.string(from: d)
    return dateString
}

fileprivate func dateAddtion(d: Date , year: Int = 0 , month: Int = 0 , day : Int) -> Date {
    var dateComponent = DateComponents()
    dateComponent.year = year
    dateComponent.month = month
    dateComponent.day = day
    let futureDate = Calendar.current.date(byAdding: dateComponent, to: d)
    return futureDate!
}


//: ## 定义【狼人任务】
struct WolfTaskInfo: Equatable, CustomStringConvertible {
    let date: Date
    let taskDesc: String
    
    var description: String {
        "\(date.description) --- \(taskDesc)"
    }
}

//: ## 定义【任务日期】
struct DayInfo: Hashable {
    let date: String
    
    init(date: Date) {
        self.date = formatDate(d: date)
    }
    
    init(date: String) {
        self.date = date
    }
}

//: ## 定义【作战计划】
//: ## 【作战计划】由【日期，任务列表】组成
struct BattlePlan {
    
    // Key：日期  Value：任务列表
    typealias BattlePlanType = [DayInfo: [WolfTaskInfo]]
    
    private var plans = BattlePlanType()
    
    init(plans: [WolfTaskInfo]) {
        // 这里使用了 Dictionary 的Group功能。
        self.plans = Dictionary(grouping: plans) { taskInfo -> DayInfo in
            return DayInfo(date: taskInfo.date)
        }
    }
}

//: ## 遵循协议-必须要实现的内容
//: ## 本身 plans 为Dictionary，即 Collection类型， 已经提供了很大的便利 😄。
extension BattlePlan: Collection {
    
    typealias KeysIndex = BattlePlanType.Index
    typealias DataElement = BattlePlanType.Element
    
    var startIndex: KeysIndex {
        return plans.startIndex
    }
    
    var endIndex: KeysIndex {
        return plans.endIndex
    }
    
    func index(after i: KeysIndex) -> KeysIndex {
        return plans.index(after: i)
    }
    
    subscript(index: KeysIndex) -> DataElement {
        return plans[index]
    }
}


let tasks = [
    WolfTaskInfo(date: Date(), taskDesc: "攻打地区A"),
    WolfTaskInfo(date: Date(), taskDesc: "攻打地区B"),
    WolfTaskInfo(date: dateAddtion(d: Date(), day: 1) , taskDesc: "攻打地区C"),
    WolfTaskInfo(date: dateAddtion(d: Date(), day: 1), taskDesc: "攻打地区D")
]

let battlePlan = BattlePlan(plans: tasks)

for (day, tasks) in battlePlan {
    print(day)
    print(tasks)
}
print("--------------------------------------------")
let battlePlanIterator: IndexingIterator<BattlePlan> = battlePlan.makeIterator()
for (day, tasks) in battlePlanIterator {
    print(day)
    print(tasks)
}
print("--------------------------------------------")


//: 下标-使用日期获取 【任务一览】。
extension BattlePlan {
    subscript(date: Date) -> [WolfTaskInfo] {
        return plans[DayInfo(date: date)] ?? []
    }
    subscript(day: DayInfo) -> [WolfTaskInfo] {
        return plans[day] ?? []
    }
}

let today = Date()
let day1 = DayInfo(date: today)
battlePlan[day1]
let day2 = DayInfo(date: dateAddtion(d: today, day: 1))
battlePlan[day2]

//: ## ExpressibleByDictionaryLiteral
//: ### Dictionary# uniquingKeysWith 使用示例
let pairsWithDuplicateKeys = [("a", 1), ("b", 2), ("a", 3), ("b", 4)]
let firstValues = Dictionary(pairsWithDuplicateKeys,
                             uniquingKeysWith: { (first, _) in first })
//: ### ["b": 2, "a": 1]
let lastValues = Dictionary(pairsWithDuplicateKeys,
                            uniquingKeysWith: { (_, last) in last })
//: ### ["b": 4, "a": 3]

extension BattlePlan: ExpressibleByDictionaryLiteral {
    init(dictionaryLiteral elements: (DayInfo, [WolfTaskInfo])...) {
        self.plans = Dictionary(elements, uniquingKeysWith: { (first, _) in
            return first
        })
    }
}

let dateA = DayInfo(date: Date())
let plansA = [
    WolfTaskInfo(date: Date(), taskDesc: "军队休整"),
    WolfTaskInfo(date: Date(), taskDesc: "攻打地区A"),
    WolfTaskInfo(date: Date(), taskDesc: "军队训练")
]
// 不会被放入到【BattlePlan】中，因为 日期和 plansA  的 相同了。
let dateB = DayInfo(date: Date())
let plansB = [
    WolfTaskInfo(date: Date(), taskDesc: "B-军队休整"),
    WolfTaskInfo(date: Date(), taskDesc: "B-攻打地区A"),
    WolfTaskInfo(date: Date(), taskDesc: "B-军队训练")
]

let adrenalinePlan: BattlePlan = [dateA: plansA, dateB: plansB]
//: [目录](目录) - [Previous page](@previous)
