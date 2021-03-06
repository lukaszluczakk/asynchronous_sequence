//
//  ContentView.swift
//  AsynchronousSequence
//
//  Created by Łukasz Łuczak on 10/12/2021.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = AppViewModel(service: AppService())
    
    @State var lastMessage = "" {
        didSet {
            isDisplayingMessage = true
        }
    }
    
    @State var isDisplayingMessage = false
    
    var body: some View {
        VStack {
            buildAppButton
            List(viewModel.logs) { info in
                BuildLogView(info)
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension ContentView {
    private var buildAppButton: some View {
        Button {
            Task {
                do {
                    try await viewModel.buildApp()
                    lastMessage = "Build was finished successfully."
                } catch {
                    print(error)
                    lastMessage = error.localizedDescription
                }
            }
        } label: {
            Text("Build app")
        }.accessibilityIdentifier("BuildAppButton")
    }
    
    private var closeMessageButton: some View {
        Button("Close", role: .cancel) { }
    }
}
