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
    
    private var appService: Service!

    override func setUpWithError() throws {
        appService = Service()
    }

    override func tearDownWithError() throws {
        appService.continuation.finish()
    }

    func testBuildAppShouldStartHandleStream() async throws {
        let vm = AppViewModel(service: appService)
        
        let exp = expectation(description: "wait for result")
        let cancellable = vm.$informations.sink { value in
            if value.count == 1 {
                exp.fulfill()
            }
        }
        
        addTeardownBlock {
            cancellable.cancel()
        }
        
        
        
        appService.continuation.yield(BuildInformation(date: .now, text: "Info 1", type: .info))
        try await vm.buildApp()
        wait(for: [exp], timeout: 2)
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

class TimeoutTask<Success> {
  let nanoseconds: UInt64
  let operation: @Sendable () async throws -> Success

  private var continuation: CheckedContinuation<Success, Error>?

  var value: Success {
    get async throws {
      try await withCheckedThrowingContinuation { continuation in
        self.continuation = continuation

        Task {
          try await Task.sleep(nanoseconds: nanoseconds)
          self.continuation?.resume(throwing: TimeoutError())
          self.continuation = nil
        }

        Task {
          let result = try await operation()
          self.continuation?.resume(returning: result)
          self.continuation = nil
        }
      }
    }
  }

  func cancel() {
    continuation?.resume(throwing: CancellationError())
    continuation = nil
  }

  init(
    seconds: TimeInterval,
    operation: @escaping @Sendable () async throws -> Success
  ) {
    self.nanoseconds = UInt64(seconds * 1_000_000_000)
    self.operation = operation
  }
}

extension TimeoutTask {
  struct TimeoutError: LocalizedError {
    var errorDescription: String? {
      return "The operation timed out."
    }
  }
}
