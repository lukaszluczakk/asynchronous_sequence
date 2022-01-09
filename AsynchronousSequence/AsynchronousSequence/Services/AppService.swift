//
//  Stream.swift
//  AsynchronousSequence
//
//  Created by Łukasz Łuczak on 10/12/2021.
//

import Foundation

protocol AppServiceProtocol {
    func build() -> AsyncThrowingStream<BuildLog, Error>
}

class AppService: AppServiceProtocol {
    private typealias BuildLogFunctionType = ((Int) -> BuildLog)
    private var buildLogFunctions: [BuildLogFunctionType] = []
    
    init() {
        buildLogFunctions.append(buildInfo)
        buildLogFunctions.append(buildWarning)
        buildLogFunctions.append(buildError)
    }

    func build() -> AsyncThrowingStream<BuildLog, Error> {
        AsyncThrowingStream { continuation in
            Task {
                for i in 1...5 {
                    let stopTime = Double.random(in: 0..<1)
                    Thread.sleep(forTimeInterval: stopTime)
                    let log = buildLogFunctions.randomElement()!(i)
                    continuation.yield(log)
                    
                    if log.type == .error {
                        continuation.finish(throwing: AppError.errorWhileBuildApp)
                    }
                }
                
                continuation.finish()
            }
        }
    }

    private func buildInfo(i: Int) -> BuildLog {
        BuildLog(date: .now, text: "AsynchronousSequence\(i).dll builded.", type: .info)
    }
    
    private func buildWarning(i: Int) -> BuildLog {
        BuildLog(date: .now, text: "AsynchronousSequence\(i).dll has unused variables.", type: .warning)
    }
    
    private func buildError(i: Int) -> BuildLog {
        BuildLog(date: .now, text: "AsynchronousSequence\(i).dll failed. CreateSequence method does not exist.", type: .error)
    }
}

extension AppError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .errorWhileBuildApp:
            return "Please fix code"
        }
    }
}

enum AppError : String {
    case errorWhileBuildApp = "Arror occured while build app"
}

enum BuildLogType: CaseIterable {
    case info, warning, error
}

struct BuildLog: Identifiable {
    let id: UUID = UUID()
    let date: Date
    let text: String
    let type: BuildLogType
}
