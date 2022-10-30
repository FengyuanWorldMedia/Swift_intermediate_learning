//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)

//: # 伪装成属性的方法

import Foundation

//: ## 个人所得税计算器(同时计算区间的税费)
struct SalaryTaxCalculator {

    var salary: Float = 0.0
    
    var taxOfLevel_1: Float {
        return 0.0
    }
    
//: ### 方法形式（为了代码的简洁，容易阅读。考虑把没有参数和只有一个返回值的方法设计成计算属性）
    func getTaxOfLevel_2() -> Float {
        if salary > 4000 {
            if salary > 5000 {
                return (5000 - 4000) * 0.03
            } else {
                return (salary - 4000) * 0.03
            }
        }
        return 0.0
    }
//: ### 计算属性形式
    var taxOfLevel_2: Float {
        if salary > 4000 {
            if salary > 5000 {
                return (5000 - 4000) * 0.03
            } else {
                return (salary - 4000) * 0.03
            }
        }
        return 0.0
    }
    
    var taxOfLevel_3: Float {
        if salary > 5000 {
            if salary > 7000 {
                return (7000 - 5000) * 0.06
            } else {
                return (salary - 5000) * 0.06
            }
        }
        return 0.0
    }
    
    var taxOfLevel_4: Float {
        if salary > 7000 {
            if salary > 14000 {
                return (14000 - 7000) * 0.12
            } else {
                return (salary - 7000) * 0.12
            }
        }
        return 0.0
    }
    
    var taxOfLevel_5: Float {
        if salary > 14000 {
            if salary > 20000 {
                return (20000 - 14000) * 0.20
            } else {
                return (salary - 14000) * 0.20
            }
        }
        return 0.0
    }
    
    var taxOfLevel_6: Float {
        salary > 20000 ? (salary - 20000) * 0.45 : 0.0
    }
    
    var totalTax: Float {
        return taxOfLevel_1 + taxOfLevel_2 + taxOfLevel_3 + taxOfLevel_4 + taxOfLevel_5 + taxOfLevel_6
    }
    
}


var  salaryCalculator = SalaryTaxCalculator()
salaryCalculator.salary = 8000
print(salaryCalculator.taxOfLevel_1)
print(salaryCalculator.getTaxOfLevel_2())
print(salaryCalculator.taxOfLevel_2)
print(salaryCalculator.taxOfLevel_3)
print(salaryCalculator.taxOfLevel_4)
print(salaryCalculator.taxOfLevel_5)
print(salaryCalculator.taxOfLevel_6)
print(salaryCalculator.totalTax)


//: ## 个人所得税计算器(通过外部税率计算税费)
struct AdvancedCalculator {
    
    // 嵌套结构体的使用
    struct TaxSetting {
        var levelName: String // 名字为 level_1, level_2, level_xx 等等
        var from: Float
        var to: Float
        var rate: Float // 在 [from, to]之间的税率, 这里认为 工资没有小数。
    }
    
    var salaryInfo: (salary: Float, taxSettings: [TaxSetting])?

//: ### 下标的定义，来弥补有参数的计算
    subscript(levelName: String) -> Float {
        guard let salaryInfo = salaryInfo ,
             let setting = salaryInfo.taxSettings.first(where: { $0.levelName == levelName}) else {
             return 0.0
        }
        let salary = salaryInfo.salary
        return getTaxOfOneLevel(taxInfo: (salary: salary, taxSetting: setting))
    }

//: ### totalTax体现了 计算属性的使用简洁性
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

advancedCalculator["level_1"]
advancedCalculator["level_2"]
advancedCalculator["level_3"]
advancedCalculator["level_4"]
advancedCalculator["level_5"]
advancedCalculator["level_6"]

advancedCalculator.totalTax

//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)
