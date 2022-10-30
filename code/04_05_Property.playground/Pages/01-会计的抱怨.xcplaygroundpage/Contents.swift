//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)

//: # 会计的抱怨

import Foundation

var greeting = "Hello, playground"

/// 简单的 个人所得税计算器
class SalaryTaxCalculator {

//: # 这个个人所得税计算器🧮，明显不合格啊 😠😠😠😠

//: ## 只能获取所得税，不能获取各个阶段的 所得税情况。
//: ## 没有办法动态调整 纳税率。
//: ## 没有办法动态调整 纳税区间。
    func getTaxBy(salary: Float) -> Float {
        
        let taxOfLevel_1: Float = 0.0
        var taxOfLevel_2: Float = 0.0
        var taxOfLevel_3: Float = 0.0
        var taxOfLevel_4: Float = 0.0
        var taxOfLevel_5: Float = 0.0
        var taxOfLevel_6: Float = 0.0
        
        var totalTax: Float = taxOfLevel_1
        
        if salary > 4000 {
            if salary > 5000 {
                taxOfLevel_2 = (5000 - 4000) * 0.03
            } else {
                taxOfLevel_2 = (salary - 4000) * 0.03
            }
            totalTax += taxOfLevel_2
        }
        
        if salary > 5000 {
            if salary > 7000 {
                taxOfLevel_3 = (7000 - 5000) * 0.06
            } else {
                taxOfLevel_3 = (salary - 5000) * 0.06
            }
            totalTax += taxOfLevel_3
        }
        
        if salary > 7000 {
            if salary > 14000 {
                taxOfLevel_4 = (14000 - 7000) * 0.12
            } else {
                taxOfLevel_4 = (salary - 7000) * 0.12
            }
            totalTax += taxOfLevel_4
        }
        
        if salary > 14000 {
            if salary > 20000 {
                taxOfLevel_5 = (20000 - 14000) * 0.20
            } else {
                taxOfLevel_5 = (salary - 14000) * 0.20
            }
            totalTax += taxOfLevel_5
        }
        
        if salary > 20000 {
            taxOfLevel_6 = (salary - 20000) * 0.45
            totalTax += taxOfLevel_6
        }
        return totalTax
    }
}


var calculator = SalaryTaxCalculator()
calculator.getTaxBy(salary: 4000)
calculator.getTaxBy(salary: 5000)
calculator.getTaxBy(salary: 8000)
calculator.getTaxBy(salary: 15000)
calculator.getTaxBy(salary: 30000)
//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)
