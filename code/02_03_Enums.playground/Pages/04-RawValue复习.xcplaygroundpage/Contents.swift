//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)

//: # RawValue复习
import Foundation

/// 关于 rawvalue（原始值）
///  Swift语言中对 RawValue的支持 有四种
///       -- String
///       -- Character
///       -- Integer Number
///       -- floating-point Number

enum Day: String {
    case Monday
    case Tuesday
    case Wednesday
    case Thursday
    case Friday
    case Saturday = "Sat"
    case Sunday
}

print(Day.Friday.rawValue)
print(Day.Saturday.rawValue)

enum Alphabet: Character {
    case alphabet_first = "a"
    case alphabet_second = "b"
    case alphabet_last = "z"
}


enum Direction: Int {
    case up  // 默认从0开始，如果第一个赋值的话，以下的都要加1
    case down
    case left
    case right
}
print(Direction.up.rawValue)
print(Direction.right.rawValue)

enum Age: Int {
    case age_10 = 10
    case age_20 = 20
    case age_50 = 50
    case age_100 = 100
}

enum PriceTag: Float {
    case level_1 = 100.11
    case level_2 = 200.11
    case level_3 = 300.11
    case level_4 = 400.11
}
 

//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)
