//: [目录](目录) - [Previous page](@previous) - [Next page](@next)

import Foundation

//: # Hashable协议概念

//: ## 散列函数
//: ### 任意长度的输入通过[散列算法]变换成固定长度的输出，该输出就是散列值。
//: ### 如果散列值的空间通常远小于输入的空间，不同的输入可能会散列成相同的输出【冲突】，所以不可能从散列值来确定唯一的输入值。
//: ### 如何设计散列函数和解决冲突，超出了我们的讨论范围。学有余力的观众，可以查阅相关资料进行学习。

//: ## Hash值特点
//: ### 相对唯一性：不同的数据大概率具有不同的哈希值
//: ### 不可逆性：不能从哈希值转换为原始数据

//: ## Swift中的Hashable协议
//: ### 1.Hashable协议，继承Equatable协议。
//: ### 2.Hashable协议中 var hashValue: Int { get } 已经为非推荐实现。所以这个可以忽视了。
//: ### 3.协议要求，如果两个对象的Hash值一样的话，那它们一定是相等（Equatable）的。

//: ## Swift中的Hashable协议 的应用
//: ### 1.Dictionary,Set数据类型的 元素要求要 实现Hashable协议 进行标识。
//: ### 2.Swift中的基本数据类型都是Hashable。例如：Character， String , Int , Double , Float , Bool 等
//: ### 3.枚举值，没有关联类型（associated values）的时候，也是Hashable
//: ### 4.结构体的属性都是Hashable的情况下，结构体实现Hashable协议，可以省略其实现。
 
struct Bullet_1: Hashable {
    var type: String
    var speed: Int
}

struct Bullet_2: Hashable {
    
    var type: String
    var speed: Int
    init(type: String , speed: Int) {
        self.type = type
        self.speed = speed
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(type)
        hasher.combine(speed)
    }
    
    static func == (lhs: Bullet_2, rhs: Bullet_2) -> Bool {
        return lhs.type == rhs.type && rhs.speed == rhs.speed
    }
}


//: ## 带有范型的Hashable 结构体
struct TwoElements<T: Hashable, U: Hashable>: Hashable {
    
    let one: T
    let another: U
    
    init(_ one: T, _ another: U) {
        self.one = one
        self.another = another
    }
}


struct TwoElementsEx<T: Hashable, U: Hashable>: Hashable {
    
    let one: T
    let another: U
    
    init(_ one: T, _ another: U) {
        self.one = one
        self.another = another
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(one)
        hasher.combine(another)
    }

    static func == (lhs: TwoElementsEx<T, U>, rhs: TwoElementsEx<T, U>) -> Bool {
        return lhs.one == rhs.one && lhs.another == rhs.another
    }
    
}


let elementsContainer = TwoElementsEx("leftValue", "rightValue")
elementsContainer.hashValue

var hasher = Hasher()
hasher.combine(elementsContainer)
// 也可以使用API: elementsContainer.hash(into: &hasher)
let hash = hasher.finalize()
print(hash) /// elementsContainer.hashValue 相同

//: ## 容器中元素都是Hashable，容器是不是Hashable呢？
//: ### 1.Dictionary,Set数据类型的 元素要求要 实现Hashable协议，其Dictionary, Set 也是 Hashable
//: ### 2.元组中每个元素是Hashable，⚠️但是，元组不是 Hashable

// 字典类型
var dic = Dictionary<String , TwoElementsEx<String, Double>>()
let p1 = TwoElementsEx<String, Double>("one", 10.001)
let p2 = TwoElementsEx<String, Double>("two", 20.001)
dic["oneValue"] = p1
dic["twoValue"] = p2
dic.hashValue

// 字典类型
var set = Set<TwoElementsEx<String, Double>>()
let p3 = TwoElementsEx<String, Double>("one", 10.001)
let p4 = TwoElementsEx<String, Double>("two", 20.001)
set.insert(p3)
set.insert(p4)
set.hashValue

// 元组
let p5 = TwoElementsEx<String, Double>("one", 20.001)
var tuple:(String, TwoElementsEx<String, Double>) = ("one", p5)
//tuple 没有 hashValue属性

var hasher2 = Hasher()
// Type '(String, LeftRightPair<String, Double>)' cannot conform to 'Hashable'
hasher2.combine(dic)
let hash2 = hasher2.finalize()
print(hash2) /// pair.hashValue 相同

//: ## 类型擦除的哈希值类型: AnyHashable
//: ### AnyHashable类型将等式比较和哈希操作转发给底层hashable值，从而隐藏其特定的底层类型。
let keyVals: [AnyHashable: Any] = [
    AnyHashable("😄"): "一个表情",
    AnyHashable(99): "一个Int数字",
    AnyHashable(Int8(100)): "一个Int8数字",
    AnyHashable(Set(["x", "y"])): "字符Set"
]

print(keyVals[AnyHashable(99)]!)
print(keyVals[AnyHashable(43)] as Any) // nil
print(keyVals[AnyHashable(Int8(100))]!)
print(keyVals[AnyHashable(Set(["x", "y"]))]!)

//: [目录](目录) - [Previous page](@previous) - [Next page](@next)
