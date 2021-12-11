//
//  Stream.swift
//  AsynchronousSequence
//
//  Created by Łukasz Łuczak on 10/12/2021.
//

import Foundation

enum BuildInformationType: CaseIterable {
    case info, warning, error
}

struct BuildInformation: Identifiable {
    let id: UUID = UUID()
    let date: Date
    let text: String
    let type: BuildInformationType
}

class ApplicationBuilder {
    func build() -> AsyncThrowingStream<BuildInformation, Error> {
        AsyncThrowingStream { continuation in
            Task {
                for i in 1...20 {
                    let stopTime = Double.random(in: 0..<1)
                    Thread.sleep(forTimeInterval: stopTime)
                    
                    let type = BuildInformationType.allCases.randomElement()!
                    let text = getText(type: type, i: i)
                    continuation.yield(BuildInformation(date: Date(), text: text, type: type))
                }
                
                continuation.finish()
            }
        }
    }
    
    private func getText(type: BuildInformationType, i: Int) -> String {
        switch (type) {
        case .info:
            return "AsynchronousSequence\(i).dll builded."
        case .warning:
            return "AsynchronousSequence\(i).dll has unused variables."
        case .error:
            return "AsynchronousSequence\(i).dll failed. CreateSequence method does not exist."
        }
    }
}

enum ApplicationBuilderError : String {
    case unknown = "Unknown error"
}

extension ApplicationBuilderError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .unknown:
            return "Unknown error occured"
        }
    }
}
