//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)

//: # 活太重露馅了

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
    
//: ## isReported 计算属性，用的不太好。
//: ### 1.脱离了计算属性的本意，过分地将一个处理放到计算属性处理中。
//: ### 2.内部的 taxBureauProxy 初始化耗时严重，且没有必要每次都 初始化一个 taxBureauProxy 。
//: ### 3. report 处理，也是耗时的处理，并发的情况下 能不能接受 不限时的等待。
    var isReported: Bool {
        // 向税务局 报税，这个过程比较耗时。
        let taxBureauProxy = TaxBureauProxy()
        if let salaryInfo = salaryInfo {
            let reported = taxBureauProxy.report(salary: salaryInfo.salary, tax: totalTax)
            return reported
        }
        return false
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
        sleep(5)
        print("已经完成向税务局报税")
        return true
    }
}

//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)
