//
//  ViewModel.swift
//  MovieApp
//
//  Created by Harrison Hibbins on 08/05/2022.
//

import Foundation
import SwiftUI

public class ViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var id: String = ""
    @Published var year: Int = 0
    @Published var releaseDate: String? = ""
    @Published var Image: String = "-"
    @Published var runningTime: String? = ""
    @Published var author: String = ""
    @Published var summary: String = "-"
    @Published var IDArray: [String] = []
    @Published var IDArrayCount: Int = 0
    
    public let movieAPI: MovieAPI
    
    public init(movieAPI: MovieAPI) {
        self.movieAPI = movieAPI
    }
    
    
    public func getNextItemInList(Index count: Int)
    {
        if IDArray.count > count
        {
            refresh(forSearch: IDArray[count], forDiscard: true)
        }
        else
        {
            print("No more items to discard")
        }
    }
    
    public func refresh(forSearch name: String, forDiscard discard: Bool) {

        
        movieAPI.searchItem(forSearch: name) { movie in DispatchQueue.main.async {
            print (name, " In dispatch queue")
            self.title = movie.title
            self.year = movie.year ?? 00
            self.Image = movie.imageURL
            self.id = movie.id
            if !discard
            {
                self.IDArray = movie.IDArray
            }
            
            
            
            
        
        }}
    }
    
    public func refreshMovieGenre(forSearch genre: String, completionHandler: @escaping () -> Void) {
        print("Search for genre")
        var finalString = "tt"
  
        movieAPI.randomMoviePopularGenre(forSearch: genre) { movie in DispatchQueue.main.async {
            
            var aString = movie.id

            let filteredChars = "\"/title"

            aString = aString.filter { filteredChars.range(of: String($0)) == nil }
            
            finalString += aString
            
            self.id = finalString
    
            print ("ID IS NOW " , self.id)
            
            completionHandler()
//            self.year = movie.year ?? 00
//            self.Image = movie.imageURL
            
            
        }}
        
//        movieAPI.searchItem(forSearch: finalString) { movie in DispatchQueue.main.async {
//            print (finalString, " In dispatch queue")
//            self.title = movie.title
//            self.year = movie.year ?? 00
//            self.Image = movie.imageURL
//            self.id = movie.id
//
//
//
//        }}
     
        
        
        
    }
    
    
    public func refreshItemOverview(forSearch name: String) {

        movieAPI.itemOverview(forSearch: name) { movie in DispatchQueue.main.async {
            self.title = movie.title
            self.releaseDate = "Release date: " + movie.releaseDate!
            
            
            self.runningTime = "Running time: " + String(movie.runningTime!) + "m"
            self.Image = movie.imageURL
            self.author = movie.author ?? ""
            self.summary = movie.description ?? ""
        }}
    }
    
}
