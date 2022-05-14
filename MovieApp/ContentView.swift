//
//  ContentView.swift
//  MovieApp
//
//  Created by Harrison Hibbins on 07/05/2022.
//

import SwiftUI
import Foundation



struct watchListView: View{
    
    @Binding var watchListItems: [WatchListItem]
    @ObservedObject var viewModel: ViewModel
    @ObservedObject var watchListViewModel: ViewModel

    @State private var WatchlistViewShowing = true;
    @State private var InfoViewShowing = false;
    
    
    
    var body: some View{
        
        ZStack
                {
                    Color("Background").ignoresSafeArea()
                    
                    if WatchlistViewShowing
                    {
                        VStack
                        {
                            Text("Your Watchlist").font(.largeTitle)
                                                   .foregroundColor(.white)
                                               
                           
                            
                            
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
                                        //cameFromWatchlist = true
                                        
                                        
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
                          
                                        
                        }
                    }
                    if InfoViewShowing
                    {
                        VStack
                        {
                            
                            HStack
                            {
                                Button(action : {
                                   
                                    
                                        loadWatchlistView()
                                        //cameFromWatchlist = false
                                    
                
                
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
                                    removeFromWatchList()
                                    
                                }, label: {
                                    Text("Remove")
                                        .padding()
                                    //   .frame(maxWidth: .infinity)
                                        .background(Color.red.cornerRadius(10))
                                        .foregroundColor(.white)
                                        .font(.headline)
                                })
                        
                            }
                            
                            
                            HStack
                            {
                                Text(watchListViewModel.title).font(.title)
                                    .foregroundColor(.white)
                                Spacer()
                            }
                            
                            
                            HStack
                            {
                                Text(watchListViewModel.releaseDate!).font(.title2)
                                    .foregroundColor(.white)
                                Spacer()
                            }
                            HStack
                            {
                                Text(watchListViewModel.runningTime!).font(.title2)
                                    .foregroundColor(.white)
                                Spacer()
                            }
                            
                            
                            
                            
                            AsyncImage(url: URL(string: watchListViewModel.Image))
                            { image in
                                image.resizable()
                                
                                    .frame(width: 300, height: 400)
                                    .scaledToFit()
                                
                                //.padding()
                            } placeholder:
                            {
                                ProgressView()
                            }
                               
                            ScrollView
                            {
                                Text(watchListViewModel.summary)
                                    .foregroundColor(.white)
                            }

                            
                        }.padding()
                    }
                    
                    
                    
                }
        
  

    }
    
    public func loadInfoView()
    {
        WatchlistViewShowing = false
        InfoViewShowing = true
    }
    
    public func loadWatchlistView()
    {
        
        WatchlistViewShowing = true
        InfoViewShowing = false
        
       // WatchListView()
    }
    
    public func getDetails(itemToSearchFor: String)
    {
        
        watchListViewModel.refreshItemOverview(forSearch: itemToSearchFor)
        print ("Searching for:" , itemToSearchFor)
        
        
    }
    
    public func saveToWatchList()
    {
        
        if !watchListItems.contains(where: {$0.id == watchListViewModel.id}) {
       
            print ("ITEM ADDED TO WATCHLIST: ", watchListViewModel.title)
            
            var item: WatchListItem = WatchListItem(title: watchListViewModel.title, id: watchListViewModel.id, url: watchListViewModel.Image, year: watchListViewModel.year)
            
            watchListItems.append(item)
        } else {
            print("Already in watchlist")
        }
}
    
    public func removeFromWatchList()
    {
        
        if watchListItems.contains(where: {$0.id == watchListViewModel.id}) {
       
            print ("ITEM REMOVED FROM WATCHLIST: ", watchListViewModel.title)
            
            var item: WatchListItem = WatchListItem(title: watchListViewModel.title, id: watchListViewModel.id, url: watchListViewModel.Image, year: watchListViewModel.year)
            
           // watchListItems.remove(item)
            
        }
}
 
}

struct DiscoverView: View {
    
    
    @ObservedObject var viewModel: ViewModel
    @Binding var watchListItems: [WatchListItem]
    
    @State private var searchText = ""

    @State public var cameFromWatchlist = false
    @State public var lastCallWasSearch = false
    
    @State private var WatchlistViewShowing = false;
    @State private var DiscoverViewShowing = true;
    @State private var InfoViewShowing = false;
    
    
    @State private var action = false
    @State private var adventure = false
    @State private var animation = false
    @State private var comedy = false
    @State private var fantasy = false
    @State private var crime = false
    @State private var horror = false
    @State private var mystery = false
    @State private var scifi = false
    @State private var thriller = false
    
    
    
    @State private var firstOpening = false;
    
    @State private var discardCount = 0;
    
    var body: some View{
              
        ZStack
                {
                    Color("Background").ignoresSafeArea()
                    
                    
                    if DiscoverViewShowing
                    {
                        VStack
                        {
                            HStack
                            {
                                
                                ZStack(alignment: .leading)
                                {
                                    if searchText.isEmpty{
                                        Text("Search For...")
                                            .font(.headline)
                                            .opacity(0.3)
                                    }
                                    TextField ("" , text: $searchText)
                                       
                                        
                                } .padding()
                                    .background(Color("SearchBarBackground").cornerRadius(10))
                                    //.background(Color("SearchBarBackground").cornerRadius(10))
                                    .foregroundColor(.white)
                                    .font(.headline)
                                    .accentColor(.white)
                              
                                    
                                
                                Button(action : {
                                    searchItem()
                                }, label: {
                                    Text("Submit")
                                        .padding()
                                        .background(Color("ButtonInFocus").cornerRadius(10))
                                        .foregroundColor(.white)
                                        .font(.headline)
                                })
                                
                            }.padding([.leading, .trailing])
                            //Spacer()
                            
                            ScrollView(.horizontal)
                            {
                                HStack
                                {
                                    Button(action : {
                                        getRandom(forGenre: "action")
                                    }, label: {
                                        Text("Action")
                                            .padding(10)
                                            .background(action ? Color("ButtonInFocus") : Color("SearchBarBackground")).cornerRadius(20)
                                            .foregroundColor(.white)
                                            .font(.headline)
                                    })
                                    Button(action : {
                                        getRandom(forGenre: "adventure")
                                    }, label: {
                                        Text("Adventure")
                                            .padding(10)
                                            .background(adventure ? Color("ButtonInFocus") : Color("SearchBarBackground")).cornerRadius(20)                           .foregroundColor(.white)
                                            .font(.headline)
                                    })
                                    Button(action : {
                                        getRandom(forGenre: "animation")
                                    }, label: {
                                        Text("Animation")
                                            .padding(10)
                                            .background(animation ? Color("ButtonInFocus") : Color("SearchBarBackground")).cornerRadius(20)                                    .foregroundColor(.white)
                                            .font(.headline)
                                    })
                                    Button(action : {
                                        getRandom(forGenre: "comedy")
                                    }, label: {
                                        Text("Comedy")
                                            .padding(10)
                                            .background(comedy ? Color("ButtonInFocus") : Color("SearchBarBackground")).cornerRadius(20)                                    .foregroundColor(.white)
                                            .font(.headline)
                                    })

                                    Button(action : {
                                        getRandom(forGenre: "crime")
                                    }, label: {
                                        Text("Crime")
                                            .padding(10)
                                            .background(crime ? Color("ButtonInFocus") : Color("SearchBarBackground")).cornerRadius(20)                                    .foregroundColor(.white)
                                            .font(.headline)
                                    })
                                    
                                    Button(action : {
                                        getRandom(forGenre: "fantasy")
                                    }, label: {
                                        Text("Fantasy")
                                            .padding(10)
                                            .background(fantasy ? Color("ButtonInFocus") : Color("SearchBarBackground")).cornerRadius(20)                                    .foregroundColor(.white)
                                            .font(.headline)
                                    })
                                    Button(action : {
                                        getRandom(forGenre: "horror")
                                    }, label: {
                                        Text("Horror")
                                            .padding(10)
                                            .background(horror ? Color("ButtonInFocus") : Color("SearchBarBackground")).cornerRadius(20)                                    .foregroundColor(.white)
                                            .font(.headline)
                                    })
                                    Button(action : {
                                        getRandom(forGenre: "mystery")
                                    }, label: {
                                        Text("Mystery")
                                            .padding(10)
                                            .background(mystery ? Color("ButtonInFocus") : Color("SearchBarBackground")).cornerRadius(20)                                    .foregroundColor(.white)
                                            .font(.headline)
                                    })
                                    Button(action : {
                                        getRandom(forGenre: "sci-fi")
                                    }, label: {
                                        Text("Sci-Fi")
                                            .padding(10)
                                            .background(scifi ? Color("ButtonInFocus") : Color("SearchBarBackground")).cornerRadius(20)                                     .foregroundColor(.white)
                                            .font(.headline)
                                    })
                                    Button(action : {
                                        getRandom(forGenre: "thriller")
                                    }, label: {
                                        Text("Thriller")
                                            .padding(10)
                                            .background(thriller ? Color("ButtonInFocus") : Color("SearchBarBackground")).cornerRadius(20)                                     .foregroundColor(.white)
                                            .font(.headline)
                                    })
                                }
                            }.padding([.leading, .trailing])
                            
                            
                            
                            
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
                                .scaledToFill()
                                .frame(width: 200, height: 350)
                                //.padding()
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
                                    Discard(nextInList: lastCallWasSearch, forGenre: "doesntmatter")
                                }, label: {
                                    Text("Discard")
                                        .padding()
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
                                        .background(Color.green.cornerRadius(10))
                                        .foregroundColor(.white)
                                        .font(.headline)
                                })
                            }.padding([.leading, .trailing, .bottom])
                            
                            HStack {
                                
                                
            //                        Button(action : {
            //                            loadWatchlistView()
            //
            //                        }, label: {
            //                            Text("Watchlist")
            //                                .padding()
            //                                .background(WatchlistViewShowing ? Color("ButtonInFocus") : Color("SearchBarBackground")).cornerRadius(10)                                 .foregroundColor(.white)
            //                                .font(.headline)
            //                        })
            //                        Button(action : {
            //                            loadDiscoverView()
            //                        }, label: {
            //                            Text("Discover")
            //                                .padding()
            //                                .background(DiscoverViewShowing ? Color("ButtonInFocus") : Color("SearchBarBackground")).cornerRadius(10)                                 .foregroundColor(.white)
            //                                .font(.headline)
            //
            //                        })
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
                               
                            ScrollView
                            {
                                Text(viewModel.summary)
                                    .foregroundColor(.white)
                            }

                            
                        }.padding()
                    }
                    
                    
                
                }
            
            
            
            .onAppear()
            {
                
                let genres: [String] = ["action","adventure","animation","comedy","crime","fantasy","horror","mystery","sci-fi","thriller"]
                
                if !firstOpening
                {
                    getRandom(forGenre: genres.randomElement()!)
                    firstOpening = true
                }
                
                
            }
            
            
        
        
    }
    public func searchItem()
    {
        discardCount = 0
        viewModel.refresh(forSearch: searchText, forDiscard: false)
        lastCallWasSearch = true
        
    }
    
    public func getDetails(itemToSearchFor: String)
    {
        
        viewModel.refreshItemOverview(forSearch: itemToSearchFor)
        print ("Searching for:" , itemToSearchFor)
        
        
    }
    
    public func Discard(nextInList nextInList: Bool, forGenre genre: String)
    {
        print(nextInList)


        if !nextInList
        {
            getRandom(forGenre: genre)
        }
        else
        {
            discardCount+=1
            viewModel.getNextItemInList(Index: discardCount)
        }
     
    }
    
    public func getRandom(forGenre genre: String)
    {
        viewModel.refreshMovieGenre(forSearch: genre){viewModel.refresh(forSearch: viewModel.getRandomItem(), forDiscard: true)}
        lastCallWasSearch = false
        
        DeselectGenres()
        switch genre
        {
        case "action":
            action = true
        case "adventure":
            adventure = true
        case "animation":
            animation = true
        case "comedy":
            comedy = true
        case "fantasy":
            fantasy = true
        case "horror":
            horror = true
        case "mystery":
            mystery = true
        case "sci-fi":
            scifi = true
        case "thriller":
            thriller = true
        default:
            DeselectGenres()
        }

        
    }

    
    public func DeselectGenres()
    {
        action = false
        adventure = false
        animation = false
        comedy = false
        crime = false
        fantasy = false
        horror = false
        mystery = false
        scifi = false
        thriller = false
    }
    
    public func GenreSelect(searchGenre genre: String)
    {
        print("Searching for" , genre)
        viewModel.emptyList()
        
        viewModel.refreshMovieGenre(forSearch: genre){viewModel.refresh(forSearch: viewModel.id, forDiscard: false)}
        lastCallWasSearch = false
        
       // viewModel.getRandomItem()
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
}

    
    
    

    
    
 
    
    
    public func loadWatchlistView()
    {
        
        DiscoverViewShowing = false
        WatchlistViewShowing = true
        
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
    


}

struct ContentView: View {
   
    @State public var watchListItems: [WatchListItem] = []
    @ObservedObject var viewModel: ViewModel
    @ObservedObject var watchListViewModel: ViewModel

    


   var body: some View
   {
  
       TabView{
           
           DiscoverView(viewModel: viewModel, watchListItems: $watchListItems)
               .tabItem {
                   Image(systemName: "eyes")
                   Text("Discover")
               }
           
           watchListView(watchListItems: $watchListItems, viewModel: viewModel,  watchListViewModel: watchListViewModel)
                   .tabItem{
                       Image(systemName: "sparkles.tv")
                      
                        
                       Text("Watchlist")
                   }
           
           
       }
       
       .onAppear {
           UITabBar.appearance().barTintColor = UIColor(.white)


           UITabBar.appearance().backgroundColor = UIColor(Color("TabBarColour"))

       }
           
             
 
       
       
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

public struct WatchListItem: Hashable
{
    var title: String
    var id: String
    var url: String
    var year: Int
}



//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView(viewModel: ViewModel(movieAPI: MovieAPI()))
//    }



