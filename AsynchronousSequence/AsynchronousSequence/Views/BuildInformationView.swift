//
//  BuildInformationView.swift
//  AsynchronousSequence
//
//  Created by Łukasz Łuczak on 20/12/2021.
//

import SwiftUI

struct BuildInformationView: View {
    private let info: BuildInformationViewModel
    
    init(_ info: BuildInformationViewModel) {
        self.info = info
    }
    
    var body: some View {
        let imageName = typeToImage(type: info.type)
        
        HStack {
            Image(systemName: imageName)
                .accessibilityLabel(imageName)
            VStack(alignment: .leading) {
                Text(info.text)
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
            BuildInformationView(dev.buildWithInfoStatus)
            BuildInformationView(dev.buildWithWarningStatus)
            BuildInformationView(dev.buildWithErrorStatus)
        }
        .previewLayout(.sizeThatFits)
        .padding()
    }
}


extension BuildInformationView {
    private func typeToImage(type: BuildInformationType) -> String {
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
