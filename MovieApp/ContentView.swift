//
//  ContentView.swift
//  MovieApp
//
//  Created by Harrison Hibbins on 07/05/2022.
//

import SwiftUI
import Foundation

struct ContentView: View {
    
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    
    
    @ObservedObject var viewModel: ViewModel
    
    static var previews: some View {
        //ContentView()
        VStack {
            Text(viewModel.title)
                .padding()
            Text(viewModel.id)
                .padding()
            Text(viewModel.Image)
                .padding()

        }.onAppear(perform: viewModel.refresh)
    }
    }
}

