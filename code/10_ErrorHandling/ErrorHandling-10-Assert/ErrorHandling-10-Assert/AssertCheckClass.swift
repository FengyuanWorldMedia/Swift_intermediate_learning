//
//  AssertCheckClass.swift
//  ErrorHandling-10-Assert
//
//  Created by nnio on 2022/8/13.
//

import Foundation

class AssertCheckClass {
    
    func testHandler() {
        testAssert()
    }
    
    // assert 测试
    func testAssert() {
        print("assert: 这是一个明显的错误")
        assert( 1>2 , "assert: 这是一个明显的错误")
    }
    
    // precondition 测试
    func testPreCondition() {
        print("precondition: 这是一个明显的错误")
        precondition(true, "precondition: 这是一个明显的错误")
    }
    
    // fatalError 测试
    func testFatalError() {
        fatalError("fatalError: 这是一个明显的错误")
    }
    
    // assertFailure 测试
    func testAssertFailure() {
        assertionFailure("assertionFailure: 这是一个明显的错误")
    }
    
    // preconditionFailure 测试
    func testPreconditionFailure() {
        preconditionFailure("preconditionFailure: 这是一个明显的错误")
    }
    
}
