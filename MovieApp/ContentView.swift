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
    @State public var watchListArray: [String] = []
    
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
                AsyncImage(url: URL(string: viewModel.Image))
                { image in
                    image.resizable()
                } placeholder:
                {
                    ProgressView()
                }
                .scaledToFit()
                .padding()
                
                
                HStack
                {
                    Text(viewModel.title)
                    
                    Spacer()
                    
                    Text(String(viewModel.year))
                }.padding()
                HStack
                {
                    Button(action : {
                        //random suggestion
                    }, label: {
                        Text("Discard")
                            .padding()
                        //   .frame(maxWidth: .infinity)
                            .background(Color.red.cornerRadius(10))
                            .foregroundColor(.white)
                            .font(.headline)
                    })
                    Spacer()
                    Button(action : {
                        saveToWatchList()
                    }, label: {
                        Text("Save")
                            .padding()
                        //   .frame(maxWidth: .infinity)
                            .background(Color.green.cornerRadius(10))
                            .foregroundColor(.white)
                            .font(.headline)
                    })
                }.padding()
            }
            
            
            
            .onAppear()
            {
                viewModel.refresh(forSearch: "Spidermannowayhome")
            }
            
        }
        
        
        
        
    }
    
    public func searchItem()
    {
        viewModel.refresh(forSearch: searchText)
    }
    
    public func saveToWatchList()
    {
        watchListArray.append(viewModel.title)
        print ("ITEM ADDED TO WATCHLIST: ", viewModel.title)
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ViewModel(movieAPI: MovieAPI()))
    }
}


