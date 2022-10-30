//: [目录](目录) - [Previous page](@previous)

import Foundation

//: # compactMap处理
//: ## 进行map操作;排除处理结果中为nil的元素。
//: ## 注意⚠️： 不是先排除nil元素，再进行map操作。

let array = [1, 2, nil, 4]
let arrayWithoutNil: Array<Int> = array.compactMap {
    print($0)
    return $0
}
print(arrayWithoutNil)
print("--------------------------------------------------")

let plusOneArray: Array<Int> = array.compactMap {
    print($0)
    if let num = $0 {
        return num + 1
    } else {
        return 0
    }
}
print(plusOneArray)
print("--------------------------------------------------")


//: # 和map以及flatMap一样，compactMap 也可以接受处理方法。

let urlStrings = [
    "https://www.fengyuantianxia.com",
    "https://www.Swift开发进阶教程.com",
    "Invalid url",
    "https://www.swift.org"
]

let urls = urlStrings.compactMap(URL.init)
print(urls)
// [https://www.fengyuantianxia.com, https://www.swift.org]

let floatStrings = ["a", "1.24", "3", "def", "45", "0.23"]

let floatData = floatStrings.compactMap { Float($0) }

print(floatData)

let floatData2 = floatStrings.compactMap(Float.init)
print(floatData2)


print("--------------------------------------------------")

//: ## 和map以及flatMap一样，compactMap 也可以进行连续操作。
//: ## 找出一组数字中，为偶数，且 满足 x + 10 > 20 的数字
//: ### 很容易，我们可以想到使用filter 去实现。但是，这次我们尝试使用compactMap
let result =
        (0..<60).map {
            _ in Int.random(in: 1...20)
        }.compactMap {
            $0 % 2 == 0 ? $0 : nil
        }.compactMap {
            $0 + 10 > 20 ? $0 : nil
        }

print(result)

print("--------------------------------------------------")
//: ## 在flatMap中嵌套使用compactMap
//: ### 组合两个字符串的字符，如果 元组中 两个元素一样的话，则忽略。
let string = "abc"
let string2 = "1ab234"

let results = string.flatMap { a -> [(Character, Character)] in
    string2.compactMap { b -> (Character, Character)? in
        if a == b {
            return nil
        } else {
            return (a, b)
        }
    }
}
print(results)

//: [目录](目录) - [Previous page](@previous)
