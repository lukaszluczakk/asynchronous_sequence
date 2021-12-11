//
//  AsynchronousSequenceViewModel.swift
//  AsynchronousSequence
//
//  Created by Łukasz Łuczak on 10/12/2021.
//

import Foundation

class AsynchronousSequenceViewModel: ObservableObject {
    @Published var informations: [BuildInformation] = []
    
    func buildApp() async throws {
        let builder = ApplicationBuilder()
        for try await info in builder.build() {
            await update(info: info)
        }
    }
    
     @MainActor func update(info: BuildInformation) {
        informations.append(info)
    }
}
