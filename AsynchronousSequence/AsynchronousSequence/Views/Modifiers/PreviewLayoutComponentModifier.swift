//
//  PreviewLayoutComponentModifier.swift
//  AsynchronousSequence
//
//  Created by Łukasz Łuczak on 20/12/2021.
//


import SwiftUI

struct PreviewLayoutComponentModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .previewLayout(.sizeThatFits)
            .padding()
    }
}

extension View {
    func preview() -> some View {
        self.modifier(PreviewLayoutComponentModifier())
    }
}
