//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)

//: # 存储属性监听

import Foundation

//: ## 个人所得税计算器(通过外部税率计算税费)
struct AdvancedCalculator {
    
    // 嵌套结构体的使用
    struct TaxSetting {
        var levelName: String // 名字为 level_1, level_2, level_xx
        var from: Float
        var to: Float
        var rate: Float // 在 [from, to]之间的税率, 这里认为 工资没有小数。
    }
    
    var salaryInfo: (salary: Float, taxSettings: [TaxSetting])?
    
    subscript(levelName: String) -> Float {
        guard let salaryInfo = salaryInfo ,
             let setting = salaryInfo.taxSettings.first(where: { $0.levelName == levelName}) else {
             return 0.0
        }
        let salary = salaryInfo.salary
        return getTaxOfOneLevel(taxInfo: (salary: salary, taxSetting: setting))
    }
    
    var totalTax: Float {
        guard let salaryInfo = salaryInfo else {
             return 0.0
        }
        let salary = salaryInfo.salary
        return salaryInfo.taxSettings.reduce(0.0) { partialResult, setting in
            partialResult + getTaxOfOneLevel(taxInfo: (salary: salary, taxSetting: setting))
        }
    }
    
    
    private func getTaxOfOneLevel(taxInfo: (salary: Float, taxSetting: TaxSetting)) -> Float {
        let salary = taxInfo.salary
        let taxSetting = taxInfo.taxSetting
        // 注意这里的判断【如果薪水小于纳税区间的下限的话，则这个区间不纳税】
        if salary < taxSetting.from {
            return 0.0
        }
        if salary > taxSetting.to {
           return (taxSetting.to - taxSetting.from) * taxSetting.rate
        } else {
           return (taxInfo.salary - taxSetting.from) * taxSetting.rate
        }
    }
        
    // lazy property 使用
    private(set) lazy var taxBureauProxy: TaxBureauProxy = {
        print("。。。。。。。。。。。。税务局代理 被初始化。。。。。。。。。。。。")
        return TaxBureauProxy()
    } ()
    
    // 完成报税
    mutating func report() -> Bool {
        if let salaryInfo = salaryInfo {
            print("--正在向税务局申报税单，在在处理中，请您稍后进行查询--")
            self.taxBureauProxy.report(salary: salaryInfo.salary, tax: totalTax)
            return true
        } else {
            return false
        }
    }
    
//: ### 个税计算器的使用者
//: ### willset 完成了存储属性监视的功能
//: ### didSet 完成了存储属性监视和修改的功能
//: ### 注意 隐式变量：newValue 和 oldValue 的使用
    var userName: String = "" {
        willSet {
            if userName.isEmpty {
                print("用户:\(newValue) 申请使用 个税计算器")
            } else {
                print("个税计算器，切换了用户:\(userName) --> \(newValue) ")
            }
        }
        didSet {
            if !oldValue.isEmpty && oldValue == userName {
                print("用户:\(oldValue) 再一次设置了用户名 😅")
            }
            if userName.lengthOfBytes(using: .utf8) <= 3 {
                print("不合法的用户申请使用👮‍♀️")
                userName = oldValue
            }
        }
    }
    
    init(){
        
    }
    
//: ## defer的使用，可以解决在初始化方法中 存储属性监听失效的问题。
    init(userName: String) {
        defer { self.userName = userName }
        self.userName = userName
    }
    
}

//: ## 税务局代理
struct TaxBureauProxy {
    // 初始化是一个【费时的】工作
    init() {
        sleep(15)
        print("完成 向税务局代理 初始化")
    }
    
    // 申报也是一个【费时的】工作
    func report(salary: Float, tax: Float) -> Bool {
        print("正在向税务局报税----，请稍等--")
        DispatchQueue.global().async {
           print("个人收入:\(salary), 纳税:\(tax)")
           print("异步完成税单申请")
        }
        print("已经完成向税务局报税")
        return true
    }
}

//: ## 个税计算器用户的切换
var advancedCalculator = AdvancedCalculator()

advancedCalculator.userName = ""

advancedCalculator.userName = "丰源天下传媒-Mr.会计"
advancedCalculator.userName = "丰源天下传媒-Mr.项目经理"

advancedCalculator.userName = "12"

print(advancedCalculator.userName)

print("")
print("")
print("")
var advancedCalculator2 = AdvancedCalculator(userName: "丰源天下传媒-Mr.项目经理")


print("advancedCalculator2 初始化完成")
//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)
