//: [回到目录](目录) - [Previous page](@previous)

//: # 回家的路

import Foundation 

enum NextDirection {
    case up
    case down
    case left
    case right
}

enum NowDirection {
    case up(NextDirection)
    case down(NextDirection)
    case left(NextDirection)
    case right(NextDirection)
}

//: 表示 当前方向是 右方向， 前进了一步，之后向下方调整了方向。
let step1: NowDirection = .right(.down)

//: 想一想，如何把 整个路径描述清楚，找到回家的路。
//: ？？？

 
//: [回到目录](目录) - [Previous page](@previous)
