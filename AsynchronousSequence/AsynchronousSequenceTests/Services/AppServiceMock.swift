//
//  AppServiceMock.swift
//  AsynchronousSequenceTests
//
//  Created by Łukasz Łuczak on 02/01/2022.
//

import Foundation
@testable import AsynchronousSequence

final class AppServiceMock: AppServiceProtocol {
    typealias ContinuationHandlerType = (AsyncThrowingStream<BuildInformation, Error>.Continuation) -> Void
    
    private var continuationHandler: ContinuationHandlerType
    
    init(continuationHandler: @escaping ContinuationHandlerType) {
        self.continuationHandler = continuationHandler
    }
    
    @discardableResult
    func build() -> AsyncThrowingStream<BuildInformation, Error> {
        AsyncThrowingStream<BuildInformation, Error> { c in
            continuationHandler(c)
        }
    }
}
