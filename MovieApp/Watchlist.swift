//
//  Watchlist.swift
//  MovieApp
//
//  Created by Harrison Hibbins on 12/05/2022.
//

import SwiftUI
import Foundation




struct WatchListView: View {
    
    var body: some View
    {
        
        VStack
        {
            Text("Your Watchlist")
            
            
//            List(watchListTitles, id:\.self){Text($0)}
            
            HStack
            {
                Button(action : {
                   // loadWatchlistView()
                    
                }, label: {
                    Text("Watchlist")
                        .padding()
                    //   .frame(maxWidth: .infinity)
                        .background(Color.green.cornerRadius(10))
                        .foregroundColor(.white)
                        .font(.headline)
                })
                Button(action : {
                  //  loadDiscoverView()
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

