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
        print ("SEARCH COUNT:" , IDArray.count)
        
        
   
        
        
        
        
        
        if self.IDArray.count > count
        {
            var finalString = "tt"
            var aString = IDArray[count]
            let filteredChars = "\"/title"

            aString = aString.filter { filteredChars.range(of: String($0)) == nil }
            
            finalString += aString
            
            
            print ("Next item in list: " , IDArray[count])
            print ("Final string: ", finalString)
            refresh(forSearch: finalString, forDiscard: true)
        }
        else
        {
            print("No more items to discard")
        }
    }
    
    
    public func refresh(forSearch name: String, forDiscard discard: Bool) {

        
        movieAPI.searchItem(forSearch: name) { movie in DispatchQueue.main.async {
            self.title = movie.title
            self.year = movie.year ?? 00
            self.Image = movie.imageURL
            self.id = movie.id
            if !discard
            {
                self.IDArray = movie.IDArray
            }
            print("For Search ID ARRAY COUNT: ", self.IDArray.count)
            
            
            
            
        
        }}
    }
    
    public func refreshMovieGenre(forSearch genre: String, completionHandler: @escaping () -> Void) {
        var finalString = "tt"
        
        var finalStrings: [String] = []
        
        movieAPI.randomMoviePopularGenre(forSearch: genre) { movie in DispatchQueue.main.async {
            
            var strings: [String] = []
            
//            for index in 0..<movie.count
//            {
//                var aString = movie[index]
//                //strings[index].append(movie[index])
//                let filteredChars = "\"/title"
//                
//                aString = movie[index].filter { filteredChars.range(of: String($0)) == nil }
//                
//                finalString += aString
//                
//                print("Item added to list" , finalString)
//                self.IDArray.append(finalString)
//                
//            }
            
            //self.IDArray = strings
            
            
            var aString = movie[0]

            print("movie count" , movie.count)

            let filteredChars = "\"/title"

            aString = aString.filter { filteredChars.range(of: String($0)) == nil }
            
            finalString += aString
            
            self.id = finalString
            
            self.IDArray = movie
            print("For Genre ID ARRAY COUNT", self.IDArray.count)
    
          
           
            completionHandler()
          
            
        }}
        

        
        
        
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
