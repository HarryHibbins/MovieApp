
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
    
    public func emptyList()
    {
        self.IDArray.removeAll()
        print(IDArray)
    }
    
    public func getRandomItem() -> String
    {

        
        print ("Random Search Count:" , IDArray.count)
        
        
        
            var finalString = "tt"
            var aString = IDArray.randomElement()
            let filteredChars = "\"/title"

        aString = aString?.filter { filteredChars.range(of: String($0)) == nil }
        finalString += aString ?? ""
            
            
            print ("Final string: ", finalString)
        return finalString
            //refresh(forSearch: finalString, forDiscard: true)
   
        
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
          //  print("For Search ID ARRAY COUNT: ", self.IDArray.count)
            print("ITEM SEACHED: ", self.title)

            
            
            
            
        
        }}
    }
    
    public func refreshMovieGenre(forSearch genre: String, completionHandler: @escaping () -> Void) {
        var finalString = "tt"
        
   
        
        movieAPI.randomMoviePopularGenre(forSearch: genre) { movie in DispatchQueue.main.async {
            

            self.IDArray.removeAll()
            print("reset count: ",self.IDArray.count)
            
            var aString = movie[0]


            let filteredChars = "\"/title"

            aString = aString.filter { filteredChars.range(of: String($0)) == nil }
            
            finalString += aString
            
            self.id = finalString
            
            self.IDArray = movie
            print("IDArray upated to: ", self.IDArray.count , "With genere:", genre)
            print(self.IDArray)
        
          
           
            completionHandler()
          
            
        }}
        

        
        
        
    }
    
    
    public func refreshItemOverview(forSearch name: String) {

        movieAPI.itemOverview(forSearch: name) { movie in DispatchQueue.main.async {
            self.title = movie.title
            self.releaseDate = "Release date: " + movie.releaseDate!
            
            if movie.runningTime != nil{
                self.runningTime = "Running time: " + String(movie.runningTime!) + "m"

            }
            
            self.Image = movie.imageURL
            self.author = movie.author ?? ""
            self.summary = movie.description ?? "No Description Avaliable"
        }}
    }
    
}
