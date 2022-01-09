//
//  AsynchronousSequenceViewModel.swift
//  AsynchronousSequence
//
//  Created by Łukasz Łuczak on 10/12/2021.
//

import Foundation

class AppViewModel: ObservableObject {
    @Published var logs: [BuildLogViewModel] = []
    
    private let service: AppServiceProtocol
    
    init(service: AppServiceProtocol) {
        self.service = service
    }
    
    func buildApp() async throws {
        for try await info in service.build() {
            await update(info: info)
        }
    }
    
     @MainActor func update(info: BuildLog) {
         logs.append(BuildLogViewModel.createFrom(info: info))
    }
}
