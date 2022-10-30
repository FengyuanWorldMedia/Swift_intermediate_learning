//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)

//: # 获取图片的内容信息-16进制显示

import Foundation
import UIKit

//: ## 步骤
//: ### 1. 使用图片资源文件（Resource/haha2.png），获取图片对象 UIImage - UIKit中定义。
//: ### 2. 根据 图片对象UIImage 获取 Data对象。
//: ### 3. 使用 Data对象的 withUnsafeBytes 方法，获取 UnsafeRawBufferPointer 对象（也就是指向Data中的对象数据的 指针）。
//: ### 4. UnsafeRawBufferPointer.baseAddress 获取  UnsafeRawPointer 对象。
//: ### 5. UnsafeRawPointer.assumingMemoryBound 尝试 数据类型绑定， 获取 UnsafePointer<UInt8> 对象。
//: ### 6. 移动指针位置（每次向前一个单位），去读 单位数据UInt8 类型。输出 指针地址和 16进制的字符。


let pngImage: UIImage = UIImage(named: "car.png")!

let imgWidth: CGFloat = pngImage.size.width
let imgHeight: CGFloat = pngImage.size.height

print(imgWidth)
print(imgHeight)

var imageData: Data = pngImage.pngData()!

print(imageData.count)

imageData.withUnsafeBytes { rawPtr in
       print(type(of: rawPtr))             // UnsafeRawBufferPointer
       print(type(of: rawPtr.baseAddress))   // Optional<UnsafeRawPointer>
       
       guard let ptr = rawPtr.baseAddress?.assumingMemoryBound(to: UInt8.self) else { return }
       
       print(type(of: ptr))                // UnsafePointer<UInt8>
       
       for i in 0..<imageData.count {
           print(ptr.advanced(by: i), String(format:"%02X", ptr.advanced(by: i).pointee))
       }
 }
//: ## 使用 car.png 图片，在线读取数据，和输出对比。
    // http://tomeko.net/online_tools/file_to_hex.php?lang=en
//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)
