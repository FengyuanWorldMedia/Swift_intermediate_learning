//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)

//: # Implicitly unwrapped optionals的理解与应用


//: ## nickName 为 Implicitly unwrapped optionals 类型，表示着 一种 “承诺”。在没有被使用前，编译器不会对它检查。
var nickName: String! = "丰源天下"
print(nickName.count)
print(nickName)

//: ### 即使没有初始化，也不会发生错误。
 var nickName1: String!
print((nickName1 ?? "").count)

//: ### 没有初始化，发生编译错误。[Variable 'nickName2' used before being initialized]
// var nickName2: String
// print(nickName2.count)

struct ScratchCards {
    var descrption: String!
    
    mutating func setDistributionInfo(desc: String) {
        self.descrption = desc
    }
}

var scratchCards = ScratchCards()
print(scratchCards.descrption ?? "没有流入市场")

scratchCards.setDistributionInfo(desc: "刮刮乐-福彩中心发行")
print(scratchCards.descrption!)
print(scratchCards.descrption.count)
//: ## Implicitly unwrapped optionals 类型在初始化中的例子

class RdbCluster {
    let name: String
    var masterNode: RdbNode!
    var subNodes = [RdbNode]()
    init(name: String, masterNodeName: String, nodeNames: String...) {
        self.name = name
        self.masterNode = RdbNode(name: masterNodeName, cluster: self)
        if !nodeNames.isEmpty {
            nodeNames.forEach({ nodeName in
                self.subNodes.append(RdbNode(name: nodeName, cluster: self))
            })
        }
    }
}

class RdbNode {
    let name: String
    unowned let cluster: RdbCluster
    
    init(name: String, cluster: RdbCluster) {
        self.name = name
        self.cluster = cluster
    }
}


//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)


