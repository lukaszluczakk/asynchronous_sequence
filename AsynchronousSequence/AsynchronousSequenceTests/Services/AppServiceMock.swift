//
//  AppServiceMock.swift
//  AsynchronousSequenceTests
//
//  Created by Łukasz Łuczak on 02/01/2022.
//

import Foundation
@testable import AsynchronousSequence

final class AppServiceMock: AppServiceProtocol {
    typealias ContinuationHandlerType = (AsyncThrowingStream<BuildLog, Error>.Continuation) -> Void
    
    private var continuationHandler: ContinuationHandlerType
    
    init(continuationHandler: @escaping ContinuationHandlerType) {
        self.continuationHandler = continuationHandler
    }
    
    @discardableResult
    func build() -> AsyncThrowingStream<BuildLog, Error> {
        AsyncThrowingStream<BuildLog, Error> { c in
            continuationHandler(c)
        }
    }
}
