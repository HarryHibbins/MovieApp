//
//  ContentView.swift
//  MovieApp
//
//  Created by Harrison Hibbins on 07/05/2022.
//

import SwiftUI
import Foundation

struct ContentView: View {
    
    @ObservedObject var viewModel: ViewModel
    @State private var searchText = ""
    
    var body: some View {
        VStack {
            Text(viewModel.title)
                .padding()
            Text(viewModel.id)
                .padding()
                .searchable(text: $searchText)
            AsyncImage(url: URL(string: viewModel.Image))
            { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
          //  .frame(width: 300, height:550 )
            //.scaledToFill()
            .scaledToFit()
            .padding()
        }.onAppear(perform: viewModel.refresh)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ViewModel(movieAPI: MovieAPI()))
    }
}


