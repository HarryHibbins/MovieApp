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
    @State public var watchListTitles: [String] = []
    @State public var watchListImages: [String] = []
    @State public var watchListYears: [Int] = []
    
    @State private var WatchlistViewShowing = false;
    @State private var DiscoverViewShowing = true;
    
    var body: some View
    {
        
        if DiscoverViewShowing
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

                    Button(action : {
                        getDetails()
                    }, label: {
                        AsyncImage(url: URL(string: viewModel.Image))
                        { image in
                            image.resizable()
                        } placeholder:
                        {
                            ProgressView()
                        }
                        .scaledToFit()
                        .padding()
                    })
          
                    
                    
                    HStack
                    {
                        Text(viewModel.title)
                        
                        Spacer()
                        
                        Text(String(viewModel.year))
                    }.padding()
                    HStack
                    {
                        Button(action : {
                            Discard()
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
                    
                    HStack {
                        Button(action : {
                            loadWatchlistView()
                            
                        }, label: {
                            Text("Watchlist")
                                .padding()
                            //   .frame(maxWidth: .infinity)
                                .background(Color.green.cornerRadius(10))
                                .foregroundColor(.white)
                                .font(.headline)
                        })
                        Button(action : {
                            loadDiscoverView()
                        }, label: {
                            Text("Discover")
                                .padding()
                            //   .frame(maxWidth: .infinity)
                                .background(Color.green.cornerRadius(10))
                                .foregroundColor(.white)
                                .font(.headline)
                        })
                    }
                    
                }
                
                
                
                .onAppear()
                {
                    viewModel.refresh(forSearch: "spidermannowayhome")
                }
                
            }
        }
        
        if WatchlistViewShowing
        {
            VStack
            {
                Text("Your Watchlist")

                
                List(watchListTitles, id:\.self){Text($0)}

                HStack
                {
                    Button(action : {
                        loadWatchlistView()
                        
                    }, label: {
                        Text("Watchlist")
                            .padding()
                        //   .frame(maxWidth: .infinity)
                            .background(Color.green.cornerRadius(10))
                            .foregroundColor(.white)
                            .font(.headline)
                    })
                    Button(action : {
                        loadDiscoverView()
                    }, label: {
                        Text("Discover")
                            .padding()
                        //   .frame(maxWidth: .infinity)
                            .background(Color.green.cornerRadius(10))
                            .foregroundColor(.white)
                            .font(.headline)
                    })
                }
                
            }
        }
        
        

    }

    
    
    public func searchItem()
    {
        viewModel.refresh(forSearch: searchText)
    }
    
    public func getDetails()
    {
        viewModel.refreshItemOverview(forSearch: searchText)
        
        
    }
    
    public func saveToWatchList()
    {
        
        if !watchListTitles.contains(viewModel.title) {
            watchListTitles.append(viewModel.title)
            watchListImages.append(viewModel.Image)
            watchListYears.append(viewModel.year)
            print ("ITEM ADDED TO WATCHLIST: ", viewModel.title)
        } else {
            print("Already in watchlist")
        }
        
        
        //
        //        let stringToSave = viewModel.title
        //
        //        var THIS_FILES_PATH_AS_ARRAY:[String] = #file.split(separator: "/").map({String($0)})
        //        print(THIS_FILES_PATH_AS_ARRAY)
        //
        //        var appendString: String = ""
        //
        //
        //        for index in 0..<THIS_FILES_PATH_AS_ARRAY.count
        //        {
        //            if (index == THIS_FILES_PATH_AS_ARRAY.count-2)
        //            {
        //                print ("NEW PATH" ,THIS_FILES_PATH_AS_ARRAY[index])
        //            }
        //            THIS_FILES_PATH_AS_ARRAY[index] += "/"
        //            appendString += THIS_FILES_PATH_AS_ARRAY[index]
        //
        //
        //            print ("APPENDED STRING: " ,appendString)
        //        }
        //
        //        let wordToRemove = "ContentView.swift/"
        //
        //
        //        if let range = appendString.range(of: wordToRemove) {
        //            appendString.removeSubrange(range)
        //        }
        //
        //        print ("APPENDED STRING: " ,appendString)
        //
        //        appendString += "Watchlist.json"
        //        print ("FINAL STRING" , appendString)
        //
        
    }
    
    
    //NOT WORKING - FIX GENRE
    public func Discard()
    {
        //change this string to drop down
        viewModel.refreshMovieGenre(forSearch: "Adventure")
    }
    
    
    public func loadWatchlistView()
    {
        
        DiscoverViewShowing = false
        WatchlistViewShowing = true
    }
    
    public func loadDiscoverView()
    {
        DiscoverViewShowing = true
        WatchlistViewShowing = false
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ViewModel(movieAPI: MovieAPI()))
    }
}


