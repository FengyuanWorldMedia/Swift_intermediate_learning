//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)

//: # 被赞赏的懒惰

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
    
//: ### lazy property 使用（税务局代理 只会初始化一次）
//: ### 这里的 private(set) 是，让 税务局代理 不可以再被设值。
    private(set) lazy var taxBureauProxy: TaxBureauProxy = {
        print("税务局代理 被初始化。。。")
        return TaxBureauProxy()
    } ()
    
//: ### 完成报税
    mutating func report() -> Bool {
        if let salaryInfo = salaryInfo {
            print("--正在向税务局申报税单，在在处理中，请您稍后进行查询--")
            self.taxBureauProxy.report(salary: salaryInfo.salary, tax: totalTax)
            return true
        } else {
            return false
        }
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
           sleep(5)
           print("异步完成税单申请")
        }
        print("已经完成向税务局报税")
        return true
    }
}


var advancedCalculator = AdvancedCalculator()
// 注意这里的 TaxSetting 的初始化方法(简单直接)
advancedCalculator.salaryInfo = (salary: 8000, taxSettings: [
    .init(levelName: "level_1", from: 0, to: 4000, rate: 0.0),
    .init(levelName: "level_2", from: 4001, to: 5000, rate: 0.03),
    .init(levelName: "level_3", from: 5001, to: 7000, rate: 0.06),
    .init(levelName: "level_4", from: 7001, to: 14000, rate: 0.12),
    .init(levelName: "level_5", from: 14001, to: 20000, rate: 0.20),
    .init(levelName: "level_6", from: 20001, to: Float.infinity, rate: 0.45)
])

advancedCalculator.taxBureauProxy
advancedCalculator.taxBureauProxy
advancedCalculator.taxBureauProxy
advancedCalculator.report()

//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)
