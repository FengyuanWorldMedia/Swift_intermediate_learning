//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)

//: # 懒得让你想不到

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
        
//: ### lazy property 使用
    private(set) lazy var taxBureauProxy: TaxBureauProxy = {
        print("。。。。。。。。。。。。税务局代理 被初始化。。。。。。。。。。。。")
        if salaryInfo?.salary ?? 0 > 10000 {
            return TaxBureauProxy(proxyType: 5)
        } else {
            return TaxBureauProxy(proxyType: 1)
        }
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
    var proxyType: Int
    // 初始化是一个【费时的】工作
    
    init(proxyType: Int) {
        self.proxyType = proxyType
        sleep(15)
        print("完成 向税务局代理 初始化")
    }
    
    // 申报也是一个【费时的】工作
    func report(salary: Float, tax: Float) -> Bool {
        print("正在向税务局报税----，请稍等--")
        DispatchQueue.global().async {
           print("个人收入:\(salary), 纳税:\(tax)")
           sleep(self.proxyType > 1 ? 5 : 2)
           print("异步完成税单申请")
        }
        print("已经完成向税务局报税")
        return true
    }
}

//: ## 税务局代理 不会被再次初始化
func test1() {
    var advancedCalculator = AdvancedCalculator()
    advancedCalculator.salaryInfo = (salary: 8000, taxSettings: [
        .init(levelName: "level_1", from: 0, to: 4000, rate: 0.0),
        .init(levelName: "level_2", from: 4001, to: 5000, rate: 0.03),
        .init(levelName: "level_3", from: 5001, to: 7000, rate: 0.06),
        .init(levelName: "level_4", from: 7001, to: 14000, rate: 0.12),
        .init(levelName: "level_5", from: 14001, to: 20000, rate: 0.20),
        .init(levelName: "level_6", from: 20001, to: Float.infinity, rate: 0.45)
    ])

    advancedCalculator.report()

    var advancedCalculatorB = advancedCalculator
    advancedCalculatorB.salaryInfo = (salary: 20000, taxSettings: [
        .init(levelName: "level_1", from: 0, to: 4000, rate: 0.1),
        .init(levelName: "level_2", from: 8001, to: 15000, rate: 0.2),
        .init(levelName: "level_3", from: 15001, to: Float.infinity, rate: 0.45)
    ])
    
    advancedCalculatorB.report()
}

// test1()


//: ## 税务局代理 会被初始化
func test2() {
    var advancedCalculator = AdvancedCalculator()
    advancedCalculator.salaryInfo = (salary: 8000, taxSettings: [
        .init(levelName: "level_1", from: 0, to: 4000, rate: 0.0),
        .init(levelName: "level_2", from: 4001, to: 5000, rate: 0.03),
        .init(levelName: "level_3", from: 5001, to: 7000, rate: 0.06),
        .init(levelName: "level_4", from: 7001, to: 14000, rate: 0.12),
        .init(levelName: "level_5", from: 14001, to: 20000, rate: 0.20),
        .init(levelName: "level_6", from: 20001, to: Float.infinity, rate: 0.45)
    ])

    var advancedCalculatorB = advancedCalculator
    
    advancedCalculatorB.salaryInfo = (salary: 20000, taxSettings: [
        .init(levelName: "level_1", from: 0, to: 4000, rate: 0.1),
        .init(levelName: "level_2", from: 8001, to: 15000, rate: 0.2),
        .init(levelName: "level_3", from: 15001, to: Float.infinity, rate: 0.45)
    ])
    
    advancedCalculator.report()
    
    advancedCalculatorB.report()
}

test2()

//: ## 讨论以下情况，lazy属性初始化 的表现？
//: ### 1.AdvancedCalculator和TaxBureauProxy 都是结构体。 （示例代码）
//: ### 2.AdvancedCalculator 是结构体， TaxBureauProxy 是类。
//: ### 3.AdvancedCalculator和TaxBureauProxy 都是类。
//: ### 4.AdvancedCalculator 是类， TaxBureauProxy 是结构体。

//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)
