//
//  PreviewProviderExtensions.swift
//  AsynchronousSequence
//
//  Created by Łukasz Łuczak on 20/12/2021.
//

import Foundation
import SwiftUI

extension PreviewProvider {
    static var dev: PreviewProviderDev {
        return PreviewProviderDev.instance
    }
}

struct PreviewProviderDev {
    static var instance = PreviewProviderDev()
    
    var buildWithInfoStatus = BuildInformationViewModel(date: "2021-12-20", text: "Some of text", type: .info)
    var buildWithWarningStatus = BuildInformationViewModel(date: "2021-12-20", text: "Some of text", type: .warning)
    var buildWithErrorStatus = BuildInformationViewModel(date: "2021-12-20", text: "Some of text", type: .error)
}
