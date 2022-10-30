//: [目录](目录) - [Previous page](@previous) - [Next page](@next)

import Foundation

//: # 通信DataModel定义和解析
//: ## JSON数据的Encode&Decode

//: ## 默认为 Codable类型
//: ###   String, Int, Float, Double, Data, Date, URL

//: ## 有条件的 Codable
//: ###  Array, Dictionary, Optional　→　元素为 Codable
//: ###  struct　→　所有的属性都为 Codable
//: ###  如果，JSON中的项目和结构体内元素同名的话，可以省略 CodingKeys 的定义。也可以 个别指定 CodingKeys中的RawValue来和JSON属性对照。

struct RequestHeader: Codable{
    var device : String
    var uuid : String
    var platform_name : String
    var user_agent : String
    var token_id : String
    init() {
        self.device = ""
        self.uuid = ""
        self.platform_name = ""
        self.user_agent = ""
        self.token_id = ""
    }
}
 
struct ResponseHeader: Codable {
    var stat : String
    var msgObjs : [ErrorMsgObject]?
    init() {
        self.stat = ""
    }
    enum CodingKeys : String, CodingKey {
         case stat = "stat"
         case msgObjs = "msgObjs"
    }
}

struct ErrorMsgObject : Codable {
    var type : String
    var code : String
    var msg : String
    init() {
        self.type = ""
        self.code = ""
        self.msg = ""
    }
    enum CodingKeys : String, CodingKey {
         case type = "type"
         case code = "code"
         case msg  = "msg"
    }
}

struct CommonRequest <T: Codable> : Codable {
    var header : RequestHeader
    var data : T?
    init() {
        self.header = RequestHeader()
    }
    init(data: T) {
        self.header = RequestHeader()
        self.data = data
    }
    enum CodingKeys : String, CodingKey {
         case header = "header"
         case data = "data"
    }
}

struct CommonResponse<T: Codable>: Codable {
    var header : ResponseHeader
    var data : T?
    init() {
        self.header = ResponseHeader()
    }
    enum CodingKeys : String, CodingKey {
         case header = "header"
         case data   = "data"
    }
}

//: ## JsonUtil 提供String和Object互转的方法
class JsonUtil {
    
    /// Parse String to JsonObject
    /// - Parameter jsonString: json string
    /// - Parameter type: json object type
    class func parseStrToJson<T: Codable>(_ jsonString: String, as type: T.Type = T.self) -> T? {
        do {
            let jsonData: Data? = jsonString.data(using: .utf8)
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: jsonData!)
        } catch {
            return nil
        }
    }
    
//    let a: StructA = parseStrToJson(jsonString)
//    let a = parseStrToJson(jsonString, StructA.self)
    
    
    /// Description: Parse JsonObject to String
    /// - Parameter json: JsonObject
    class func parseJsonToStr<T: Codable> (_ json: T) -> String {
        do {
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(json)
            encoder.outputFormatting = .prettyPrinted
            return String(data: jsonData, encoding: .utf8)!
        } catch {
            return ""
        }
    }
    /// Description: Parse JsonObject to Data
    /// - Parameter json: JsonObject
    class func parseJsonToData<T: Codable> (_ json: T ) -> Data? {
        do {
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(json)
            return jsonData
        } catch {
            return nil
        }
    }
}

//: ## WolfActionReq 为Request请求的 data部分定义
struct WolfActionReq : Codable {
    var wolfManId : String
    var type : Int
    var time : String
    init() {
        self.wolfManId = "狼人1号"
        self.type = 0
        self.time = Date().formatted()
    }
    enum CodingKeys : String, CodingKey {
         case wolfManId = "wolf_man_id"
         case type = "type"
         case time = "time"
    }
}

//: ### 测试
func test() {
    var header = RequestHeader()
    header.device = "xx device"
    header.uuid = "xx uuid"
    header.platform_name = "xx platform_name"
    header.user_agent = "xx user_agent_userid"
    header.token_id = "1111555500010061"
    
    let req = WolfActionReq()
     
    let reqData = CommonRequest<WolfActionReq>(data: req)
    
    print(JsonUtil.parseJsonToStr(reqData))
}

test()


//: ### 虽然超出了讨论范围。说明一下: 父子类的情况，Codable互相独立。继承的属性需要在子类中重新encode&decode
//: ### 不推荐使用类对象来实现Codable协议。因为，结构体对象具有的便利性和轻量化，已经足够使用。
class MonsterWolf {
    var name = "Animal"
}

class MonsterWolfMan: MonsterWolf, Encodable, Decodable {
    var nickName = "Wolf"

    enum CodingKeys: String, CodingKey {
        case name
        case nickName
    }

    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.nickName = try container.decode(String.self, forKey: .nickName)
        self.name = try container.decode(String.self, forKey: .name)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(nickName, forKey: .nickName)
        try container.encode(name, forKey: .name)
    }
}

//: ## 更多关于codable，请参考官网 https://developer.apple.com/documentation/swift/codable

//: ## EncodingContainer
//: ### KeyedEncodingContainer 字典
//: ### UnkeyedEncodingContainer 数列
//: ### SingleValueEncodingContainer 单一值

//: ## DecodingContainer
//: ### KeyedContainer 字典
//: ### UnkeyedDecodingContainer 数列
//: ### SingleValueDecodingContainer  单一值

//: ## 嵌套的情况下使用
//: ### container.nestedContainer 字典
//: ### container.nestedUnKeyedContainer 数列

//: [目录](目录) - [Previous page](@previous) - [Next page](@next)
