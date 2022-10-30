//: [回到目录](目录) - [Previous page](@previous)

//: # RawPresentable协议中Optional的使用

enum Number {
    case zero
    case one
    case n(Int)
}

//: ## 学习和实现 RawRepresentable协议
extension Number: RawRepresentable {
    
//: ### 特别注意 init? 的构造方法定义。
    init?(rawValue: Int) {
        switch rawValue {
            case 0: self = .zero
            case 1: self = .one
            case let n:
                if n < 0 {
                    return nil
                } else {
                    self = .n(n)
                }
        }
    }

    var rawValue: Int {
        switch self {
            case .zero: return 0
            case .one: return 1
            case let .n(n): return n
        }
    }
}

//: ## 学习和实现 ExpressibleByIntegerLiteral协议
extension Number: ExpressibleByIntegerLiteral {
    init(integerLiteral value: Int) {
        self.init(rawValue: value)!  // 注意这里 为什么可以是用 ！
    }
}

//: ## 学习和实现 ExpressibleByStringLiteral协议
extension Number: ExpressibleByStringLiteral {
    init(stringLiteral value: String) {
        if let num = Int(value) { // 注意这里 为什么 使用 if
            self.init(rawValue: num)!
        } else {
            self = .zero          // self 的赋值
        }
    }
}


let num1 = Number(rawValue: 1)
num1?.rawValue

let num2: Number = 0

let num3: Number = "12345"

let num4: Number = "aa"


//: [回到目录](目录) - [Previous page](@previous)
