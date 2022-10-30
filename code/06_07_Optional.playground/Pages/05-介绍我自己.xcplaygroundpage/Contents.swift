
//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)

//: # Optional和If以及Switch语句

//: ## 银行客户信息


enum Ranking {
    case gold
    case silver
}

struct CustomerInfo {
    let id: String
    let email: String
    let firstName: String?
    let lastName: String?
    let balance: Int
    let ranking: Ranking?
}

let customer = CustomerInfo(id: "0005", email: "wangzhiyou@bank.com", firstName: "王", lastName: "志友", balance: 80000, ranking: .gold)

//: ### 使用if-let语句进行解包（unwrap）
if let firstName = customer.firstName {
    print("First name : \(firstName)")
}

//: ### 使用if-let语句进行 多个Optional解包（unwrap）
if let firstName = customer.firstName, let lastName = customer.lastName {
    print("First name : \(firstName), last name : \(lastName)")
}

//: ### 使用if-let语句进行 多个Optional解包（unwrap）,同时增加逻辑判断
if let firstName = customer.firstName, let lastName = customer.lastName, customer.balance > 5000 {
    print("First name : \(firstName), last name : \(lastName), balance: \(customer.balance)")
}

//: ### 使用 PartialRangeFrom 模式匹配~= 运算符，进行范围判断
if let firstName = customer.firstName, 4500..<5000 ~= customer.balance {
   print("\(firstName) 有余额 \(customer.balance), 余额范围：[4500,5000）")
}

switch customer.balance {
case 4500..<5000:
    print("customer.balance 4500..<5000")
default:
    print("other")
}
//: ### 使用if-let语句进行 多个Optional解包（unwrap）,忽略Optional里的值
if let _ = customer.firstName, let _ = customer.lastName {
    print("这个客户有 firstName 和 lastName")
}

//: ### 使用Optional 得 != 运算符，进行判断
if customer.firstName != nil, customer.lastName != nil {
    print("这个客户有 firstName 和 lastName")
}

//: ### 枚举类型为Optional 的判断方法
//: #### if-let语句 解包
if let ranking = customer.ranking {
  switch ranking {
      case .gold: print("金卡持有者")
      case .silver: print("银卡持有者")
  }
} else {
  print("普通会员")
}

//: #### 模式匹配
switch customer.ranking {
    case .gold?: print("金卡持有者")
    case .silver?: print("银卡持有者")
    case nil: print("普通会员")
}

//: ### 把Optioanl类型 当成 枚举switch进行解包（unwrap）
switch customer.firstName {
    case .some(let name): print("First name :  \(name)")
    case .none: print("first name is nil")
}

//: ### 利用Optioanl类型的 模式匹配~= 运算符，switch进行解包（unwrap）
switch customer.firstName {
    case let name?: print("First name :  \(name)")
    case nil: print("first name is nil")
}

//: ## 介绍我自己，使用 switch 语句 和 CustomStringConvertible 协议
//: ### 实际开发中，推荐实现CustomStringConvertible 协议
//: ###  1.可以快速方便地获取Debug信息
//: ###  2.可以业务处理上使用
extension CustomerInfo: CustomStringConvertible {
    var description: String {
        var desc: String = "我的名字："
        switch(firstName, lastName) {
            case (nil, nil):
                desc +=  "没有录入"
            case let (nil, lastN?):
                desc +=  lastN
            case let (firstN?, nil):
                desc +=  firstN
            case let (firstN?, lastN?):
                desc = "\(desc): \(firstN) \(lastN)"
        }
        desc = "\(desc), 邮箱:\(email), 我有存款:\(balance)"
        return desc
    }
}

print(customer)

//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)
