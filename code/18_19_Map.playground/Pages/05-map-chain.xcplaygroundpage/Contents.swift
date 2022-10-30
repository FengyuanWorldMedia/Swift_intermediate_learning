//: [目录](目录) - [Previous page](@previous) - [Next page](@next)

import Foundation

//: # Map Pipeline
//: ## 学习使用 处理链 processing chain .

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
        .init(date: "2055-12-12 12:12:15".toDate(.localDateTimeSec), taskDesc: "攻打C1地区"),
        .init(date: "2055-12-12 13:12:15".toDate(.localDateTimeSec), taskDesc: "攻打C2地区"),
        .init(date: "2055-12-12 14:12:15".toDate(.localDateTimeSec), taskDesc: "攻打C3地区"),
        .init(date: "2055-12-12 15:12:15".toDate(.localDateTimeSec), taskDesc: "攻打C4地区"),
    .init(date: "2055-12-12 20:12:15".toDate(.localDateTimeSec), taskDesc: "军队休整")
]

//: ## 学习使用 处理链 processing chain
// 获取 任务中 2055-12-12 的 攻打任务，按照时间排序
func counts(date: String , tasks: Array<WolfTaskInfo> ) -> Array<(String, String)> {
    return tasks
        .filter {
            formatDate(d: $0.date) == date && $0.taskDesc.contains("攻打")
        }.sorted {
            $0.date < $1.date
        }.map {
            ($0.date.description, $0.taskDesc)
        }
}


let plans = counts(date: "2055-12-12", tasks: tasks)

plans.forEach {
    print("\($0.0) : \($0.1)")
}

print("--------------------------------------------------------------------------------------------------------------------")

//: ## 学习使用 连续使用 map.

//: ### 移除表情字符
func removeEmojis(_ string: String) -> String {
     var scalars = string.unicodeScalars
     scalars.removeAll(where: { $0.properties.isEmoji })
     return String(scalars)
}

//: ### 移除违禁词
func removeStopWords(_ string: String) -> String {
    let stopWords = ["stop1","stop2","stop3"]
    var result = string
    stopWords.forEach {
        result = result.wipeCharacters(characters: $0)
    }
    return result
}

//: ### 想一想，如果 将 String？变为String， 会是什么情况？
let nameOfWofMan: String? = "😊😅 狼人一号🐺👌，将要🌊🌊🌊🌊🌊 stop1,stop2 ⭐️⭐️勇往直前⭐️⭐️! 😍❤️🐮🐮"

let name = nameOfWofMan
            .map(removeEmojis)
            .map(removeStopWords)
            .map {
                "🚩🚩🚩🚩\($0)🚩🚩🚩🚩"
            }
print(name!)

//: [目录](目录) - [Previous page](@previous) - [Next page](@next)
