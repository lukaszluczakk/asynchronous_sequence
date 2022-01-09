//
//  BuildInformationViewModel.swift
//  AsynchronousSequence
//
//  Created by Łukasz Łuczak on 20/12/2021.
//

import Foundation

struct BuildLogViewModel: Identifiable {
    let id: UUID = UUID()
    let date: String
    let text: String
    let type: BuildLogType
}

extension BuildLogViewModel {
    static func createFrom(info: BuildLog) -> BuildLogViewModel {
        BuildLogViewModel(date: info.date.formatted(), text: info.text, type: info.type)
    }
}
