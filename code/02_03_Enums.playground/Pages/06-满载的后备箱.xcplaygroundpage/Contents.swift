//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)

//: # 满载的后备箱

import Foundation

//: 各种商品的结构体定义
struct Book {
    let name: String = "概率论与游戏📖"
    let price: Float = 12.5
    let desc: String = "科学🔬玩游戏🎮"
}
struct Bread {
    let name: String = "吐司🍞"
    let price: Float = 1.5
    let weight: Int = 150
}
struct Drink {
    let name: String = "wine"
    let tag: String  = "夏日清凉"
    let total: Int = 5 // 瓶
}
struct Tool {
    let name: String = "扳手🔧"
    let manual: String  = "一看就懂"// 使用方法
}

//: 使用 子类的设计
class Goods {
    var name: String = ""
}
class BookOfGoods: Goods {
    let price: Float = 0.0
    let desc: String = ""
}
class BreadOfGoods: Goods {
    let price: Float = 0.0
    let weight: Int = 0
}
class DrinkOfGoods: Goods {
    let tag: String = "" // 夏日清凉
    let total: Int = 0 // 5 瓶
}
class ToolOfGoods: Goods {
    let manual: String = "" // 使用方法
}

//: 使用内部 枚举的设计方法
struct GoodsInfo {
    enum GoodType {
       case Book
       case Bread
       case Drink
       case Tool
    }
    let type: GoodType
    let name: String
    let price: Float
    let desc: String
    let weight: Int
    let tag: String // 夏日清凉
    let total: Int // 5 瓶
    let manual: String // 使用方法
}

//: 如此，设计方法带来了麻烦，那就直接放弃，不使用子类 也不使用枚举。 直接使用 各种结构体

let arrOfGoods: [Any] = [Book(), Bread(), Drink(), Tool()]

//: 感觉使用Any类型，解决了 混乱的分支, 同时在编译的时候 switch 语句容易发生！遗漏！。
for goods: Any in arrOfGoods {
    // goods 是 "Any" 类型
    switch goods {
        case let book as Book: print("您购买了: \(book)")
        case let bread as Bread: print("您购买了: \(bread)")
        case let drink as Drink: print("您购买了: \(drink)")
        case let tool as Tool: print("您购买了: \(tool)")
        default: print("您买的什么物品呀，我分不清了") // 问题出现了。！！！容易遗漏的情况！！！
    }
}


//: 使用 枚举，进行设计，多态(Polymorphism)的体现。
enum GoodsType {
    case book(Book)
    case bread(Bread)
    case drink(Drink)
    case tool(Tool)
}

let goods_1 = GoodsType.book(Book())
let goods_2 = GoodsType.book(Book())
let goods_3 = GoodsType.bread(Bread())
let goods_4 = GoodsType.drink(Drink())
let goods_5 = GoodsType.tool(Tool())
 
let goodsList: [GoodsType] = [ goods_1, goods_2, goods_3, goods_4, goods_5]

for item in goodsList {
    switch item {
        case .book(let book): print("您购买了: \(book)")
        case .bread(let bread): print("您购买了: \(bread)")
        case .drink(let drink): print("您购买了: \(drink)")
        case .tool(let tool): print("您购买了: \(tool)")
    }
}

//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)
