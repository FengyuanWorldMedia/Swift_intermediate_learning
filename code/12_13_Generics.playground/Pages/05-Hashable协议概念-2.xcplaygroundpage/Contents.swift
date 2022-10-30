//: [目录](目录) - [Previous page](@previous) - [Next page](@next)

import Foundation

//: # Hashable协议概念-2
//: ## 类实现Hashable协议

class WolfClass { }
class WolfSecondClass { }
class WolfThirdClass { }


extension WolfClass : Hashable  {
    func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
    static func == (lhs: WolfClass, rhs: WolfClass) -> Bool {
        return lhs === rhs
    }
}

extension WolfSecondClass : Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
    static func ==(lhs: WolfSecondClass, rhs: WolfSecondClass) -> Bool {
        return lhs === rhs
    }
}


extension WolfThirdClass : Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
    static func ==(lhs: WolfThirdClass, rhs: WolfThirdClass) -> Bool {
        return lhs === rhs
    }
}


//: ## 消除重复的代码
extension Hashable where Self: AnyObject {
    func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs === rhs
    }
}


class WolfClassEx {}
class WolfSecondClassEx {}
class WolfThirdClassEx {}


extension WolfClassEx: Hashable {
    
}

extension WolfSecondClassEx : Hashable {
    
}
extension WolfThirdClassEx : Hashable {
    
}


//: [目录](目录) - [Previous page](@previous) - [Next page](@next)
