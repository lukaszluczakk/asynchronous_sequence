//
//  BuildInformationViewModel.swift
//  AsynchronousSequence
//
//  Created by Łukasz Łuczak on 20/12/2021.
//

import Foundation

struct BuildInformationViewModel: Identifiable {
    let id: UUID = UUID()
    let date: String
    let text: String
    let type: BuildInformationType
}

extension BuildInformationViewModel {
    static func createFrom(info: BuildInformation) -> BuildInformationViewModel {
        BuildInformationViewModel(date: info.date.formatted(), text: info.text, type: info.type)
    }
}
