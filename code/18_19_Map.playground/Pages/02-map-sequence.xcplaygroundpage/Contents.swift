//: [目录](目录) - [Previous page](@previous) - [Next page](@next)

import Foundation

//: # 在Squence类型进行map操作
//: ##  学习使用Squence#Map
 
struct WolfTaskInfo: Equatable, CustomStringConvertible {
    let date: Date
    let taskDesc: String
    var description: String {
        "\(date.description) --- \(taskDesc)"
    }
}

let tasks: Array<WolfTaskInfo> = [
    .init(date: "2055-10-10 09:12:15".toDate(.localDateTimeSec), taskDesc: "军队训练"),
    .init(date: "2055-10-10 12:12:15".toDate(.localDateTimeSec), taskDesc: "攻打A地区"),
    .init(date: "2055-10-10 20:12:15".toDate(.localDateTimeSec), taskDesc: "军队休整"),
    .init(date: "2055-11-11 09:12:15".toDate(.localDateTimeSec), taskDesc: "军队训练"),
    .init(date: "2055-11-11 12:12:15".toDate(.localDateTimeSec), taskDesc: "攻打B地区"),
    .init(date: "2055-11-11 20:12:15".toDate(.localDateTimeSec), taskDesc: "军队休整"),
    .init(date: "2055-12-12 09:12:15".toDate(.localDateTimeSec), taskDesc: "军队训练"),
    .init(date: "2055-12-12 12:12:15".toDate(.localDateTimeSec), taskDesc: "攻打C地区"),
    .init(date: "2055-12-12 20:12:15".toDate(.localDateTimeSec), taskDesc: "军队休整")
]


//: ## 任务时间一览
let listOfTime = tasks.map({$0.date.description})
print(listOfTime.joined(separator: "\n"))

print("--------------------------------------------------------------------------------------------------------------------")

//: ## 15次轮值情况
let nameCount = tasks.count

let turns = (0..<15).map { index in
    return tasks[index % nameCount]
}

turns
    .enumerated()
    .forEach { (index: Int , task: WolfTaskInfo) -> Void in
        print("No.\(index + 1) : \(task.description)")
    }

//: [目录](目录) - [Previous page](@previous) - [Next page](@next)
