//: [目录](目录) - [Previous page](@previous) - [Next page](@next)

import Foundation

//: # MutableCollection
//: ## 特点：可以修改元素，长度不变

//: ## 常见的 MutableCollection 类型
//: ### Array
//: ### Dictionary.Values
//: ### ContiguousArray(元素在内存上连续排列)
//: ### ArraySlice （Slices是Arrays的View表现，不另开辟内存. 但各自的修改互不影响）

var mutableArray = [4,3,1,2]
mutableArray.sort() // [1, 2, 3, 4]

print(mutableArray)

let absences = [0, 2, 0, 4, 0, 3, 1, 0]
let midpoint = absences.count / 2
var firstHalf: ArraySlice<Int> = absences[..<midpoint]
let secondHalf: ArraySlice<Int> = absences[midpoint...]

firstHalf[0] = 100
print(absences)

struct WolfMan {
    var name: String = ""
    var magicPoint: Int = 0
}

var wolfMen: Array<WolfMan> = []
wolfMen.append(WolfMan(name: "4号", magicPoint: 25))
wolfMen.append(WolfMan(name: "5号", magicPoint: 10))
wolfMen.append(WolfMan(name: "6号", magicPoint: 15))
wolfMen.append(WolfMan(name: "7号", magicPoint: 20))
let midpointW = wolfMen.count / 2

//: ## 官方提醒⏰
//: ### 不鼓励长期存储ArraySlice实例。切片包含对更大阵列的整个存储的引用，而不仅仅是它所呈现的部分，甚至在原始阵列的生命周期结束之后。
//: ### 因此，片的长期存储可能会延长不再可访问的元素的寿命，这可能看起来是内存和对象泄漏。
var firstHalfW: ArraySlice<WolfMan> = wolfMen[..<midpoint]
var secondHalfW: ArraySlice<WolfMan> = wolfMen[midpoint...]

//: ## 修改Array和SliceArray后，互不影响
firstHalfW[0].name = "new name"
print(wolfMen[0].name)
wolfMen[0].name = "new name 1"
print(firstHalfW[0].name)

print("------------------------------------")

//: ### 注意点⚠️：String 不是MutableCollection。
//: ### 因为字符编码的原因，交换unicode scalar可能改变字符串的长度,这是 MutableCollection协议不允许的。
// 参考： https://www.compart.com/en/unicode/

func countSequence<T: Sequence>(s: T) -> Int {
    var count = 0
    for _ in s {
        count += 1
    }
    return count
}

print("-日语平仮名 が （ga）-----------------------------------")
print("\u{3099}")                                  // 濁点 符号
print("\u{3099}".unicodeScalars)
print("\u{3099}".unicodeScalars.count)               // => 1
print("か\u{3099}")                                // => が
print(countSequence(s: "か\u{3099}"))
print("\u{3099}か")   // => 1  が
print(countSequence(s: "\u{3099}か"))              // => 2
print(countSequence(s: "か\u{3099}".unicodeScalars)) // => 2

print("-俄语字母 ё （yo）-----------------------------------")
print("ё")
print("\u{0435}\u{0308}")   // e + 重音符 = ё ， 字符长度 1
print("\u{0308}\u{0435}")   // 重音符 + e = 重音符 + e  ， 字符长度 2


//: [目录](目录) - [Previous page](@previous) - [Next page](@next)
