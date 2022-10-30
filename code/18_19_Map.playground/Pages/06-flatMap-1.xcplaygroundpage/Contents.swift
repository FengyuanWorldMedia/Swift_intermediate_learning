//: [目录](目录) - [Previous page](@previous) - [Next page](@next)

import Foundation

//: # flatMap处理
//: ## 使用flatMap，可以“平铺”含有嵌套数据类型的数组。

let array = [
    "1",
    "2",
    ["3-1","3-2"],
    ["4-1","4-2", ["4-3-1", "4-3-2"]],
    "5"
] as [Any]

print(type(of: array)) // Array<Any>


//: ## 如果通过循环去获取 嵌套数组的元素 非常麻烦。如果层级比较深的情况，更麻烦。
func putEle<T>(result: inout Array<Any>, parameter: T) {
    if parameter is Int {
        print("Int")
    } else if (parameter is Float) || (parameter is Double) {
        print("Double")
    } else if parameter is String {
        print("String")
    } else if parameter is Bool {
        print("Bool")
    } else {
        // assert(false, "Unsupported type")
    }
    result.append(parameter)
}

//: ## 这里给出一个 递归的方法获取其元素的方法。
func flattenArray<T>(result: inout Array<Any>, parameter: Array<T>) {
    for element in parameter {
        if let arr = element as? Array<Any> {
            flattenArray(result: &result, parameter: arr)
        } else {
            putEle(result: &result, parameter: element)
        }
    }
}

var result = [Any]()
flattenArray(result: &result, parameter: array)

print(result)

//: ## flatMap 更方便的获取同样的结果。

/// 警告内容 😄，错误的使用。
/// 'flatMap' is deprecated: Please use compactMap(_:) for the case where closure returns an optional value
var result2 = array.flatMap {
    $0
}
print(result2) // ["1", "2", ["3-1", "3-2"], ["4-1", "4-2", ["4-3-1", "4-3-2"]], "5"]

print("--------------------------------")
let result3 = [["1", "2"], ["3-1", "3-2"], ["4-1", "4-2"], ["5", ["5-1"]]].flatMap { element in
    print(element)
    return element
}
print(result3)
print("--------------------------------")
let result4 = [[["1", "2"],["3-1", "3-2"]], [["1", "2"],["3-1", "3-2"]]].flatMap { $0 }
print(result4) // [["1", "2"], ["3-1", "3-2"], ["1", "2"], ["3-1", "3-2"]]

//: ## ⚠️flatMap 针对的类型是 [[Element]]
//: ## 根据这个，可以扩展Array，使其可以“平铺”所有元素（这里也是使用递归方法）。
//: ## 这个方法比 带有inout参数的实现,【内存消耗】要更大一些。
extension Array {
    func flattenAll() -> [Any] {
        return self.flatMap { element -> [Any] in
            if let eleAsArray = element as? [Any] {
                return eleAsArray.flattenAll()
            } else {
                return [element]
            }
        }
    }
}

print(array.flattenAll())

//: [目录](目录) - [Previous page](@previous) - [Next page](@next)
