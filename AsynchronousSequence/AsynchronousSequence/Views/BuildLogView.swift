//
//  BuildInformationView.swift
//  AsynchronousSequence
//
//  Created by Łukasz Łuczak on 20/12/2021.
//

import SwiftUI

struct BuildLogView: View {
    private let info: BuildLogViewModel
    
    init(_ info: BuildLogViewModel) {
        self.info = info
    }
    
    var body: some View {
        let imageName = typeToImage(type: info.type)
        
        HStack {
            Image(systemName: imageName)
            VStack(alignment: .leading) {
                Text(info.text)
                    .accessibilityIdentifier("BuildLogView_Text")
                    .font(.caption)
                Text(info.date)
                    .font(.caption2)
            }
        }
    }
}

struct BuildInformationView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            BuildLogView(dev.buildWithInfoStatus)
            BuildLogView(dev.buildWithWarningStatus)
            BuildLogView(dev.buildWithErrorStatus)
        }
        .preview()
    }
}


extension BuildLogView {
    private func typeToImage(type: BuildLogType) -> String {
        switch (type) {
        case .info:
            return "checkmark.diamond.fill"
        case .warning:
            return "exclamationmark.triangle.fill"
        case .error:
            return "xmark.octagon.fill"
        }
    }
}
