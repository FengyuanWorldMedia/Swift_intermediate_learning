
//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)

//: # 使用 assign & moveAssign
//: ## 在理解指针状态的基础上，学会使用
//: ### UnsafeMutablePointer#initialize(from:, count:)
//: ### UnsafeMutablePointer#assign(from:, count:)
//: ### UnsafeMutablePointer#moveInitialize(from:, count:)
//: ### UnsafeMutablePointer#moveAssign(from:, count:)

import Foundation

//: ## case 1. UnsafeMutablePointer#initialize(from:, count:)
let source1 = UnsafeMutablePointer<Int>.allocate(capacity: 1)
source1.initialize(to: 100)

let dest1 = UnsafeMutablePointer<Int>.allocate(capacity: 1)
dest1.initialize(from: source1, count: 1)

print(dest1.pointee)

//: ## case 2. UnsafeMutablePointer#assign(from:, count:)
let source2 = UnsafeMutablePointer<Int>.allocate(capacity: 1)
source1.initialize(to: 111)

let dest2 = UnsafeMutablePointer<Int>.allocate(capacity: 1)
dest2.initialize(to: 200)
dest2.assign(from: source1, count: 1)

print(dest2.pointee)

//: ## case 3. UnsafeMutablePointer#moveInitialize(from:, count:)
let source3 = UnsafeMutablePointer<Int>.allocate(capacity: 1)
source3.initialize(to: 333)

let dest3 = UnsafeMutablePointer<Int>.allocate(capacity: 1)
dest3.moveInitialize(from: source3, count: 1)

print(dest3.pointee)

//: ## case 4. UnsafeMutablePointer#moveAssign(from:, count:)
let source4 = UnsafeMutablePointer<Int>.allocate(capacity: 1)
source4.initialize(to: 444)

let dest4 = UnsafeMutablePointer<Int>.allocate(capacity: 1)
dest4.initialize(to: 200)
dest4.moveAssign(from: source4, count: 1)

print(dest4.pointee)

//: [回到目录](目录) - [Previous page](@previous) - [Next page](@next)
