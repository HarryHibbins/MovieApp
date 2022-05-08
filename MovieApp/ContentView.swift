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
    
    var body: some View
    {
        
        NavigationView
            {
                VStack
                {
                    HStack
                    {
                        TextField ("Search for...", text: $searchText)
                            .padding()
                            .background(Color.gray.opacity(0.3).cornerRadius(10))
                            .foregroundColor(.red)
                            .font(.headline)
                            
                        Button(action : {
                            searchItem()
                        }, label: {
                            Text("Submit")
                                .padding()
                             //   .frame(maxWidth: .infinity)
                                .background(Color.blue.cornerRadius(10))
                                .foregroundColor(.white)
                                .font(.headline)
                        })
                      
                    }.padding()
                    Spacer()
                    Text(viewModel.title)
                                   .padding()
                               AsyncImage(url: URL(string: viewModel.Image))
                               { image in
                                   image.resizable()
                               } placeholder:
                               {
                                   ProgressView()
                               }
                               .scaledToFit()
                               .padding()
                   
                           }.onAppear()
                           {
                               viewModel.refresh(forSearch: "Breakingbad")
                           }
                }
                   
        
       
                      
    }
    
    public func searchItem()
    {
        viewModel.refresh(forSearch: searchText)
    }
}
        

      
            
    
//        VStack
//        {
//            Text(viewModel.title)
//                .padding()
//            AsyncImage(url: URL(string: viewModel.Image))
//            { image in
//                image.resizable()
//            } placeholder:
//            {
//                ProgressView()
//            }
//            .scaledToFit()
//            .padding()
//
//        }.onAppear()
//        {
//            viewModel.refresh(forSearch: "Breakingbad")
//        }
    




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ViewModel(movieAPI: MovieAPI()))
    }
}


