//
//  AsynchronousSequenceTests.swift
//  AsynchronousSequenceTests
//
//  Created by Łukasz Łuczak on 10/12/2021.
//

import XCTest
import Combine
@testable import AsynchronousSequence

class AppViewModelTests: XCTestCase {
    
    func testBuildAppShouldHandleStream() async throws {
        let service = AppServiceMock { c in
            c.yield(BuildLog(date: .now, text: "Info 1", type: .info))
            c.finish()
        }
        
        let viewModel = AppViewModel(service: service)
        var result: [BuildLogViewModel] = []
        let cancellable = viewModel.$logs.sink { value in
            result = value
        }
        
        addTeardownBlock {
            cancellable.cancel()
        }
        
        try await viewModel.buildApp()
        XCTAssertEqual(1, result.count)
    }
}
