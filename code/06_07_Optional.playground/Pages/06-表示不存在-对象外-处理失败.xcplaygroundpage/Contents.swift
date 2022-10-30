//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)

//: # 可选类型的表达意义: 表示不存在-对象外-处理失败

import Foundation

//: ## Optional 在 构造方法中使用, 表示 初始化失败，且返回nil
struct Card {
    var name: String
    init?(name: String) {
        if name.isEmpty {
            return nil
        } else {
            self.name = name
        }
    }
}

//: ## Optional 在 结构体或者类对象中使用，表示该字段为 可选项目
class CardObject {
    typealias COMPLETION_HANDLER = (String?, String?) -> Bool?
    
    var name: String?
    var basicInfo: (String?, String?)?
    var errorHandler: ((String) -> Void)?
    var completionHandler: COMPLETION_HANDLER?
}

struct CardStruct {
    typealias COMPLETION_HANDLER = (String?, String?) -> Bool?
    
    var name: String?
    var basicInfo: (String?, String?)?
    var errorHandler: ((String) -> Void)?
    var completionHandler: COMPLETION_HANDLER?
}


//: ## Optional 作为方法参数的默认值,表示此参数可以省略
func errorHander(errorInfo: String? = nil) -> Void {
    
}
errorHander()
errorHander(errorInfo: "Error")


func errorHanderEx(errorInfo: String? = nil, customErrorHandler: ((String?) -> Void)? = nil) -> Void {
    
}
errorHanderEx()
errorHanderEx(errorInfo: "Error")
errorHanderEx(errorInfo: "Error", customErrorHandler: nil)
func customErrorHandler(_ info: String?) -> Void {
}
errorHanderEx(customErrorHandler: customErrorHandler)
errorHanderEx(errorInfo: "Error", customErrorHandler: customErrorHandler)

//: ## 思考 errorInfoEx 的类型该如何解释？
func errorHanderEx2(errorInfo: String? = nil, errorInfoEx: (String?)? = nil) -> Void {
    
}

//: ## nil 的返回值，有时也表达着处理的失败
enum MyError: Error {
    case notFound
    case fail(String)
}

func getName() throws -> String {
    throw MyError.fail("fatal error.")
}

let name = try? getName()

//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)
