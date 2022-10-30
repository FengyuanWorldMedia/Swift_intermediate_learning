//: [目录](目录) - [Previous page](@previous) - [Next page](@next)

import Foundation

//: # 在Optional类型进行map操作
//: ## Optional # func map<U>(_ transform: (Wrapped) throws -> U) rethrows -> U?
//: ### 注意⚠️： 闭包的参数不是 Optional ，但是 返回的类型是 Optional 类型。
//: ### 注意⚠️： 不过，还是得注意 层级比较深的Optional数据类型; 如果U时 Optional类型， 则 U？ 为 Optional<Optional<U>>.

let possibleNumber: Int? = Int("42")
let possibleSquare = possibleNumber.map { $0 * $0 }
print(possibleSquare)
// Prints "Optional(1764)"

let noNumber: Int? = nil
let noSquare = noNumber.map { $0 * $0 }
print(noSquare)
// Prints "nil"

print("--------------------------------------------------------------------------------------------------------------------")

struct WolfTaskInfo: Equatable, CustomStringConvertible {
    let date: Date
    let taskDesc: String
    var description: String {
        "\(date.description) --- \(taskDesc)"
    }
}

let tasks: Array<WolfTaskInfo?> = [
    .init(date: "2055-10-12 09:12:15".toDate(.localDateTimeSec), taskDesc: "军队训练"),
    .init(date: "2055-10-12 12:12:15".toDate(.localDateTimeSec), taskDesc: "攻打A地区"),
    .init(date: "2055-10-12 20:12:15".toDate(.localDateTimeSec), taskDesc: "军队休整"),
    nil,
    nil
]

tasks
    .enumerated()
    .forEach { (index: Int , task: WolfTaskInfo?) -> Void in
        print("No.\(index + 1)")
        let taskDesc: String? = task.map({ $0.description })
        print("    任务描述： \(taskDesc ?? "没有任务。。。")")
    }

//: [目录](目录) - [Previous page](@previous) - [Next page](@next)
