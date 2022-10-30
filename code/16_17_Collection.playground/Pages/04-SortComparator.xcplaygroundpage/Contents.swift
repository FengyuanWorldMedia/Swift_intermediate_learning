//: [目录](目录) - [Previous page](@previous) - [Next page](@next)

import Foundation

//: # AnySortComparator 的实现方法
//: ## SortComparator 的意义在于，数据对象和比较逻辑分离。

//: ## Sequence ## func sorted<Comparator>(using: Comparator) -> [Self.Element]

struct AnySortComparator<Compared>: SortComparator {
    private let _compare: (Compared, Compared) -> ComparisonResult
    private let initialOrder: SortOrder
    private let hashableObj: AnyHashable
    
    // 在 compare 中使用
    var order: SortOrder
    
    var base: Any {
        hashableObj.base
    }
    
    // 在 compare 中使用
    func compare(_ lhs: Compared, _ rhs: Compared) -> ComparisonResult {
       let result = _compare(lhs, rhs)
       if order != initialOrder {
           return result.inverted()
       } else {
           return result
       }
    }

    init<T>(_ base: T) where T: SortComparator, T.Compared == Self.Compared {
        _compare = base.compare(_:_:)
        initialOrder = base.order
        order = base.order
        hashableObj = AnyHashable(base)
    }
}

extension AnySortComparator: Hashable {
    static func == (lhs: AnySortComparator<Compared>, rhs: AnySortComparator<Compared>) -> Bool {
        lhs.hashableObj == rhs.hashableObj && lhs.order == rhs.order
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(hashableObj)
        hasher.combine(order)
    }
}

extension ComparisonResult {
    func inverted() -> Self {
        switch self {
        case .orderedSame:
            return self
        case .orderedAscending:
            return .orderedDescending
        case .orderedDescending:
            return .orderedAscending
        }
    }
}

func test_order1() {
   var comparator = KeyPathComparator(\Int.self)
   var erasedComparator = AnySortComparator(KeyPathComparator(\Int.self))

   let randomData = [4,-2,20,13,8,0,9,-4]

   let sorted = randomData.sorted(using: comparator)
   let sortedByErased = randomData.sorted(using: erasedComparator)
   
   print(sorted)
   print(sortedByErased)

   comparator.order = .reverse
   erasedComparator.order = .reverse

   let sortedReverse = randomData.sorted(using: comparator)
   let sortedReverseByErased = randomData.sorted(using: erasedComparator)

   print(sortedReverse)
   print(sortedReverseByErased)
}

test_order1()

func test_order2() {
   let forward = AnySortComparator(KeyPathComparator(\Int.self, order: .forward))
   let reverse = AnySortComparator(KeyPathComparator(\Int.self, order: .reverse))

   let randomData = [4,-2,20,13,8,0,9,-4]

   let sortedForward = randomData.sorted(using: forward)
   let sortedReverse = randomData.sorted(using: reverse)

   print(sortedForward)
   print(sortedReverse)
}

test_order2()


//: ## 实现 Comparable 协议
struct WolfMan: Comparable {
    static func < (lhs: WolfMan, rhs: WolfMan) -> Bool {
        return lhs.magicPoint < rhs.magicPoint
    }
    static func == (lhs: WolfMan, rhs: WolfMan) -> Bool {
        return lhs.magicPoint == rhs.magicPoint
    }
    
    var name: String = ""
    var magicPoint: Int = 0
     
}

func test_order3() {
   let forward = AnySortComparator(KeyPathComparator(\WolfMan.self, order: .forward))
   let reverse = AnySortComparator(KeyPathComparator(\WolfMan.self, order: .reverse))
    
   var wolfMen: Array<WolfMan> = []
   wolfMen.append(WolfMan(name: "4号", magicPoint: 25))
   wolfMen.append(WolfMan(name: "5号", magicPoint: 10))
   wolfMen.append(WolfMan(name: "6号", magicPoint: 15))
   wolfMen.append(WolfMan(name: "7号", magicPoint: 20))

   let sortedForward = wolfMen.sorted(using: forward)
   let sortedReverse = wolfMen.sorted(using: reverse)
    
   print(sortedForward)
   print(sortedReverse)
}

test_order3()

//: ## 想一想🤔️，以下的方法定义如何理解，又如何使用??
// 【Sequence # func sorted<S, Comparator>(using comparators: S) -> [Self.Element] where S : Sequence, Comparator : SortComparator, Comparator == S.Element, Self.Element == Comparator.Compared】

//: [目录](目录) - [Previous page](@previous) - [Next page](@next)
