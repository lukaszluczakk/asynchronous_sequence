//
//  Stream.swift
//  AsynchronousSequence
//
//  Created by Łukasz Łuczak on 10/12/2021.
//

import Foundation

enum BuildInformationType {
    case info, warning, error
}

struct BuildInformation: Identifiable {
    let id: UUID = UUID()
    let date: Date
    let text: String
    let type: BuildInformationType
}

class ApplicationBuilder {
    func build() -> AsyncStream<BuildInformation> {
        AsyncStream { continuation in
            Task {
                continuation.yield(BuildInformation(date: Date(), text: "App.dll builed", type: .info))
                Thread.sleep(forTimeInterval: 5)
                continuation.yield(BuildInformation(date: Date(), text: "App.dll builed", type: .info))
                continuation.finish()
            }

        }
    }
}
