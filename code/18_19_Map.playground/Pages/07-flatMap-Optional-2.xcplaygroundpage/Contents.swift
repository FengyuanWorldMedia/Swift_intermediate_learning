//: [目录](目录) - [Previous page](@previous) - [Next page](@next)

import Foundation

//: # flatMap对Optional操作
//: ## flatMap的连续操作示例

//: ## 设定一场景
//: ### 狼人夜行，每次前进10 公里，中途又可能被射杀，概率为50%。
//: ### 有个 行进任务，共55公里，行进4次，狼人🐺是不是还 存活？

//: ## 如果返回 nil ，表示 狼人被射杀。 返回里程数 小于10 公里的情况，每次都成功；如果成功行进，返回的里程数-10。
func proceed(_ mileage: Int) -> Int? {
    if mileage < 10 {
        print("💐💐行进成功💐💐")
        return mileage
    }
    // 被射杀
    if Bool.random() {
        return nil
    } else {
        return mileage - 10
    }
}

let totalMileage = 55

//: ## 这是行进4次的情况，判断比较恐怖😱，且容易出错
if let left1 = proceed(totalMileage) {
    if let left2 = proceed(left1) {
        if let left3 = proceed(left2) {
            if let left4 = proceed(left3) {
                print(left4)
            } else {
                print("行进失败")
            }
        } else {
            print("行进失败")
        }
    } else {
        print("行进失败")
    }
} else {
    print("行进失败")
}

//: ## 另外的一种写法, 感觉好多了。但还是觉得 let 语句比较繁琐。
if let left1 = proceed(totalMileage),
    let left2 = proceed(left1),
    let left3 = proceed(left2),
    let left4 = proceed(left3) {
    print(left4)
} else {
    print("行进失败")
}

//: ## 理解：flatMap 的重复利用，参数和返回值的关系.
let left4 = proceed(totalMileage)
            .flatMap(proceed)
            .flatMap(proceed)
            .flatMap(proceed)

if let left4 = left4 {
    print(left4)
} else {
    print("行进失败")
}

//: [目录](目录) - [Previous page](@previous) - [Next page](@next)
