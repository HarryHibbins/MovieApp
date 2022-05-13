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
//    @State public var watchListTitles: [String] = []
//    @State public var watchListImages: [String] = []
//    @State public var watchListYears: [Int] = []
    @State public var watchListItems: [WatchListItem] = []
    @State public var cameFromWatchlist = false
    
    
    @State private var WatchlistViewShowing = false;
    @State private var DiscoverViewShowing = true;
    @State private var InfoViewShowing = false;
    
    @State private var discardCount = 0;
    
    var body: some View
    {
            
        ZStack
        {
            Color("Background").ignoresSafeArea()
                //.ignoresSafeArea()
            
            
            if DiscoverViewShowing
            {
                
                VStack
                {
                    HStack
                    {
                        TextField ("Search for...", text: $searchText)
                            .padding()
                            .background(Color("SearchBarBackground").cornerRadius(10))
                            .foregroundColor(.white)
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
                        loadInfoView()
                        getDetails(itemToSearchFor: viewModel.id)
                        
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
                        Text(viewModel.title).font(.title)
                            .foregroundColor(.white)
                            .lineLimit(50)

                        
                        Spacer()
                        if viewModel.year != 0
                        {
                            Text(String(viewModel.year)).font(.title3)
                                .foregroundColor(.white)
                        }
                      
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
                    //viewModel.refresh(forSearch: "spidermannowayhome"
                    //viewModel.refreshMovieGenre(forSearch: "Adventure")
                    //viewModel.refresh(forSearch: viewModel.id)
                    viewModel.refreshMovieGenre(forSearch: "Adventure"){viewModel.refresh(forSearch: viewModel.id, forDiscard: false)}
                    
                }
                
                
            }
            
            if WatchlistViewShowing
            {
                VStack
                {
                    Text("Your Watchlist").font(.largeTitle)
                        .foregroundColor(.white)
                    
                    
                    //List(watchListTitles, id:\.self){Text($0)}
                    
                    ScrollView
                    {
                        ForEach (watchListItems, id: \.self) { item in
                            
                            HStack
                            {
                                Text(item.title).font(.title)
                                    .foregroundColor(.white)
                                Spacer()
                            }
                            HStack
                            {
                                Text(String(item.year)).font(.title3)
                                    .foregroundColor(.white)
                                Spacer()
                            }
                            
                            Button(action : {
                                loadInfoView()
                                getDetails(itemToSearchFor: item.id)
                                cameFromWatchlist = true
                                
                                
                            }, label: {
                            AsyncImage(url: URL(string:   item.url))
                                { image in
                                    image.resizable()
                                } placeholder:
                                {
                                    ProgressView()
                                }
                                .scaledToFit()
                                //.padding()
                            })
                            
                                                    
                          
                            
                        }
                    }.padding()
                  
                    
        
                    
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
            
            if InfoViewShowing
            {
                VStack
                {
                    
                    HStack
                    {
                        Button(action : {
                            if !cameFromWatchlist
                            {
                                loadDiscoverView()
                            }
                            else {
                                loadWatchlistView()
                                cameFromWatchlist = false
                            }
                            
                            
                        }, label: {
                            Text("Back")
                                .padding()
                            //   .frame(maxWidth: .infinity)
                                .background(Color.green.cornerRadius(10))
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
                    }
                    
                    
                    HStack
                    {
                        Text(viewModel.title).font(.title)
                            .foregroundColor(.white)
                        Spacer()
                    }
                    
                    
                    HStack
                    {
                        Text(viewModel.releaseDate!).font(.title2)
                            .foregroundColor(.white)
                        Spacer()
                    }
                    HStack
                    {
                        Text(viewModel.runningTime!).font(.title2)
                            .foregroundColor(.white)
                        Spacer()
                    }
                    
                    
                    
                    
                    AsyncImage(url: URL(string: viewModel.Image))
                    { image in
                        image.resizable()
                        
                            .frame(width: 300, height: 400)
                            .scaledToFit()
                        
                        //.padding()
                    } placeholder:
                    {
                        ProgressView()
                    }
                    
                    
                    
                    
                    
                    
                    //Text(viewModel.author)
                    
                    ScrollView
                    {
                        Text(viewModel.summary)
                            .foregroundColor(.white)
                    }
                    
                    
                    
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
                    
                }.padding()
                 
            }
            
            
            
            
        }
        
        
        
    }
    
    
    
    public func searchItem()
    {
        viewModel.refresh(forSearch: searchText, forDiscard: false)
        
    }
    
    public func getDetails(itemToSearchFor: String)
    {
        
        viewModel.refreshItemOverview(forSearch: itemToSearchFor)
        print ("Searching for:" , itemToSearchFor)
        
        
    }
    
    public func Discard()
    {
        //change this string to drop down
        //viewModel.refreshMovieGenre(forSearch: "Adventure"){viewModel.refresh(forSearch: viewModel.id)}

        discardCount+=1
        viewModel.getNextItemInList(Index: discardCount)
    //    viewModel.refresh(forSearch: viewModel.IDArray[discardCount])


       
        
        
        
        
   
    }
    
    public func saveToWatchList()
    {
        
        if !watchListItems.contains(where: {$0.id == viewModel.id}) {
       
            print ("ITEM ADDED TO WATCHLIST: ", viewModel.title)
            
            var item: WatchListItem = WatchListItem(title: viewModel.title, id: viewModel.id, url: viewModel.Image, year: viewModel.year)
            
            watchListItems.append(item)
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
    
    
 
    
    
    public func loadWatchlistView()
    {
        
        DiscoverViewShowing = false
        WatchlistViewShowing = true
        InfoViewShowing = false
        
       // WatchListView()
    }
    
    public func loadDiscoverView()
    {
        DiscoverViewShowing = true
        WatchlistViewShowing = false
        InfoViewShowing = false
    }
    
    public func loadInfoView()
    {
        DiscoverViewShowing = false
        WatchlistViewShowing = false
        InfoViewShowing = true
    }
    
    public struct WatchListItem: Hashable
    {
        var title: String
        var id: String
        var url: String
        var year: Int
    }

}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ViewModel(movieAPI: MovieAPI()))
    }
}


