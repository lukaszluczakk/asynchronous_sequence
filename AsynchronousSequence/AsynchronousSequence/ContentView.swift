//
//  ContentView.swift
//  AsynchronousSequence
//
//  Created by Łukasz Łuczak on 10/12/2021.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = AsynchronousSequenceViewModel()
    
    var body: some View {
        VStack {
            Button {
                Task {
                    await viewModel.buildApp()
                }
            } label: {
                Text("Build app")
            }
            List(viewModel.informations) { info in
                VStack {
                    Text(info.text)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
