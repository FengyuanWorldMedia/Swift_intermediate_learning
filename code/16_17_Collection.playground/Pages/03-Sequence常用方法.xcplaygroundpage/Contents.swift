//: [目录](目录) - [Previous page](@previous) - [Next page](@next)

import Foundation

//: # Sequence常用方法

//: ## 遍历
struct WolfMan {
    var name: String = ""
    var magicPoint: Int = 0
}

var wolfMen: Array<WolfMan> = [WolfMan(name: "1号"), WolfMan(name: "2号"), WolfMan(name: "3号")]

wolfMen.forEach { wolf in
    print(wolf.name)
}

wolfMen.forEach(printWolfName)

func printWolfName(wolf: WolfMan) {
    print(wolf.name)
}

//: ## 如果想要拿到元素的索引值，枚举enumerated
wolfMen
    .enumerated()
    .forEach { (index: Int, element: WolfMan) in
        print("\(index+1): \(element.name)")
    }

//: ## Lazy,不到真正获取值的时候，是不会计算的
wolfMen.append(WolfMan(name: "4号", magicPoint: 5))
wolfMen.append(WolfMan(name: "5号", magicPoint: 10))
wolfMen.append(WolfMan(name: "6号", magicPoint: 15))
wolfMen.append(WolfMan(name: "7号", magicPoint: 20))

// 过滤 MP值大于等于10 的元素，一共三个 .  filtered --> LazyFilterSequence
let filtered = wolfMen.lazy.filter { (wolf) -> Bool in
    print("过滤计算开始-\(wolf.name)")
    return wolf.magicPoint >= 10
}

// 过滤后，获取最后的两个元素
let lastTwo = filtered.filter({
    print("filter")
    return $0.magicPoint == 50 ||  $0.magicPoint == 15
    
})

print("Lazy??")

//: ## 体验 filter的计算时间点。
print("这时候才开始计算，【太Lazy！！😂】")
for value in lastTwo {
    print(value)
}

//: ## 获取所有狼人MP值之和，Reduce 和 Reduce Into
let initValue = 0
var tatalMP = 0
tatalMP = wolfMen.reduce(initValue) { (accumulation: Int, wolf: WolfMan) in
    return accumulation + wolf.magicPoint
}

print(tatalMP)

let initInoutMP = 0
var inoutMP = 0

//: ## Reduce Into 不需要返回临时变量，一直使用同一个 对象数据，提高了性能！
let result = wolfMen.reduce(into: initInoutMP) { (inoutMP: inout Int ,wolf: WolfMan)  in
    inoutMP += wolf.magicPoint
}

//: ## zip
var wolfWomen: Array<WolfMan> = [WolfMan(name: "11号"), WolfMan(name: "22号"), WolfMan(name: "33号")]

for (male, female) in zip(wolfMen, wolfWomen) {
    print("\(male.name): \(female.name)")
}

// 输出:
// 1号: 11号
// 2号: 22号
// 3号: 33号

//: randomSplit macOS 13.0+ Beta
// let teams = wolfMen + wolfWomen
// let two: (ArraySlice<WolfMan>, ArraySlice<WolfMan>) =  teams.randomSplit(by:seed:)

//: [目录](目录) - [Previous page](@previous) - [Next page](@next)
