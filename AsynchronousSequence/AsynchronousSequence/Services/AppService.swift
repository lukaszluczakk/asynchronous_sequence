//
//  Stream.swift
//  AsynchronousSequence
//
//  Created by Łukasz Łuczak on 10/12/2021.
//

import Foundation

protocol AppServiceProtocol {
    func build() -> AsyncThrowingStream<BuildInformation, Error>
}

class AppService: AppServiceProtocol {
    private typealias BuildInformationFunctionType = ((Int) -> BuildInformation)
    private var buildInformationFunctions: [BuildInformationFunctionType] = []
    
    init() {
        buildInformationFunctions.append(buildInfo)
        buildInformationFunctions.append(buildWarning)
        buildInformationFunctions.append(buildError)
    }

    func build() -> AsyncThrowingStream<BuildInformation, Error> {
        AsyncThrowingStream { continuation in
            Task {
                for i in 1...5 {
                    let stopTime = Double.random(in: 0..<1)
                    Thread.sleep(forTimeInterval: stopTime)
                    let model = buildInformationFunctions.randomElement()!(i)
                    continuation.yield(model)
                    
                    if model.type == .error {
                        continuation.finish(throwing: AppError.errorWhileBuildApp)
                    }
                }
                
                continuation.finish()
            }
        }
    }

    private func buildInfo(i: Int) -> BuildInformation {
        BuildInformation(date: .now, text: "AsynchronousSequence\(i).dll builded.", type: .info)
    }
    
    private func buildWarning(i: Int) -> BuildInformation {
        BuildInformation(date: .now, text: "AsynchronousSequence\(i).dll has unused variables.", type: .warning)
    }
    
    private func buildError(i: Int) -> BuildInformation {
        BuildInformation(date: .now, text: "AsynchronousSequence\(i).dll failed. CreateSequence method does not exist.", type: .error)
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

enum BuildInformationType: CaseIterable {
    case info, warning, error
}

struct BuildInformation: Identifiable {
    let id: UUID = UUID()
    let date: Date
    let text: String
    let type: BuildInformationType
}
