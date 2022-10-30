//: [目录](目录) - [Previous page](@previous) - [Next page](@next)

import Foundation

//: # 在字典类型进行map操作
//: ##  学习使用Dictionary#Map 和 Dictionary#mapValues
 
struct WolfTaskInfo: Equatable, CustomStringConvertible {
    let date: Date
    let taskDesc: String
    var description: String {
        "\(date.description) --- \(taskDesc)"
    }
}

let tasks: Array<WolfTaskInfo> = [
    .init(date: "2055-10-12 09:12:15".toDate(.localDateTimeSec), taskDesc: "军队训练"),
    .init(date: "2055-10-12 12:12:15".toDate(.localDateTimeSec), taskDesc: "攻打A地区"),
    .init(date: "2055-10-12 20:12:15".toDate(.localDateTimeSec), taskDesc: "军队休整"),
    .init(date: "2055-11-12 09:12:15".toDate(.localDateTimeSec), taskDesc: "军队训练"),
    .init(date: "2055-11-12 12:12:15".toDate(.localDateTimeSec), taskDesc: "攻打B地区"),
    .init(date: "2055-11-12 20:12:15".toDate(.localDateTimeSec), taskDesc: "军队休整"),
    .init(date: "2055-12-12 09:12:15".toDate(.localDateTimeSec), taskDesc: "军队训练"),
    .init(date: "2055-12-12 12:12:15".toDate(.localDateTimeSec), taskDesc: "攻打C地区"),
    .init(date: "2055-12-12 20:12:15".toDate(.localDateTimeSec), taskDesc: "军队休整")
]

//: ### 学习使用Dictionary(grouping:by:)
let taskInfoDict: [String: [WolfTaskInfo]] = Dictionary(grouping: tasks, by: { formatDate(d:$0.date) })

//: ### 学习使用Dictionary#Map
var taskDetails = taskInfoDict.map { (day: String, tasks: [WolfTaskInfo]) -> [String] in
    var result = [String]()
    result.append("----任务日期: \(day)  ➡️")
    tasks
        .enumerated()
        .forEach { (index: Int, element: WolfTaskInfo) in
            result.append("No.\(index + 1) : \(element.description)")
        }
    return result
}

taskDetails.forEach({print($0)})

print("--------------------------------------------------------------------------------------------------------------------")
//: ### 学习使用Dictionary#mapValues
var taskDetails2 = taskInfoDict.mapValues { (taskParam: [WolfTaskInfo]) -> [String] in
    var result = [String]()
    taskParam
        .enumerated()
        .forEach { (index: Int, element: WolfTaskInfo) in
            result.append("No.\(index + 1) : \(element.description)")
        }
    return result
}

taskDetails2.forEach({
    print("\($0.key): ")
    print("    \($0.value.joined(separator: "\n    "))")
})

//: [目录](目录) - [Previous page](@previous) - [Next page](@next)
