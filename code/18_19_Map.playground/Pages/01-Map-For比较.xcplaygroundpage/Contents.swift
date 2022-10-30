//: [目录](目录) - [Previous page](@previous) - [Next page](@next)

import Foundation

//: # Map VS For

struct WolfTaskInfo: Equatable, CustomStringConvertible {
    let date: Date
    let taskDesc: String
    var description: String {
        "\(date.description) --- \(taskDesc)"
    }
}

let tasks = [
    "2055-10-12": [WolfTaskInfo(date: "2055-10-12 09:12:15".toDate(.localDateTimeSec), taskDesc: "军队训练"),
                   WolfTaskInfo(date: "2055-10-12 12:12:15".toDate(.localDateTimeSec), taskDesc: "攻打A地区"),
                   WolfTaskInfo(date: "2055-10-12 20:12:15".toDate(.localDateTimeSec), taskDesc: "军队休整")
                  ],
    "2055-11-12": [WolfTaskInfo(date: "2055-11-12 09:12:15".toDate(.localDateTimeSec), taskDesc: "军队训练"),
                   WolfTaskInfo(date: "2055-11-12 12:12:15".toDate(.localDateTimeSec), taskDesc: "攻打B地区"),
                   WolfTaskInfo(date: "2055-11-12 20:12:15".toDate(.localDateTimeSec), taskDesc: "军队休整")
                  ],
    "2055-12-12": [WolfTaskInfo(date: "2055-12-12 09:12:15".toDate(.localDateTimeSec), taskDesc: "军队训练"),
                   WolfTaskInfo(date: "2055-12-12 12:12:15".toDate(.localDateTimeSec), taskDesc: "攻打C地区"),
                   WolfTaskInfo(date: "2055-12-12 20:12:15".toDate(.localDateTimeSec), taskDesc: "军队休整")
                  ]
]

//: ### 迭代方法
func showTaskInfos_for(by day: String) -> [String] {
    var taskInfos = [String]()
    if let taskList = tasks[day] {
        for e in taskList {
            taskInfos.append(e.description)
        }
    }
    return taskInfos
}

print(showTaskInfos_for(by: "2055-10-12").joined(separator: "\n"))

print("--------------------------------------------------------------------------------------------------------------------")
//: ### map（函数式）
func showTaskInfos_map(by day: String) -> [String] {
    if let taskInfos = tasks[day]?.map({ $0.description }) {
        return taskInfos
    } else {
        return []
    }
}

print(showTaskInfos_map(by: "2055-10-12").joined(separator: "\n"))

//: ### PPT文档 【对比Map和For语句】。

//: [目录](目录) - [Previous page](@previous) - [Next page](@next)
