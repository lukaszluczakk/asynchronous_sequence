//
//  AsynchronousSequenceTests.swift
//  AsynchronousSequenceTests
//
//  Created by Łukasz Łuczak on 10/12/2021.
//

import XCTest
@testable import AsynchronousSequence

class AppViewModelTests: XCTestCase {
    
    private var service: Service!

    override func setUpWithError() throws {
        service = Service()
    }

    override func tearDownWithError() throws {
        service.continuation.finish()
    }

    func testBuildAppShouldHandleAsyncStream() throws {

    }
    
    class Service: AppServiceProtocol {
        public private(set) var continuation: AsyncThrowingStream<BuildInformation, Error>.Continuation!
        
        init() {
            build()
        }
        
        @discardableResult
        func build() -> AsyncThrowingStream<BuildInformation, Error> {
            AsyncThrowingStream<BuildInformation, Error> { c in
                continuation = c
            }
        }
    }
}
