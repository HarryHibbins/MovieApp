//
//  MovieAPI.swift
//  MovieApp
//
//  Created by Harrison Hibbins on 07/05/2022.
//

import Foundation
import UIKit
import SwiftUI

public final class MovieAPI : NSObject
{
    
    private var completionHandler: ((Item) -> Void)?
    private var completionHandlerGenre: (([String]) -> Void)?
    private var completionHandlerOverview: ((Item) -> Void)?
    
    
    public func searchItem(forSearch name: String, _ completionHandler: @escaping((Item) -> Void) )
    {
        self.completionHandler = completionHandler
        
        getItemBySearch(forSearch: name)
        
    }
    
    public func randomMoviePopularGenre(forSearch genre: String, _ completionHandlerGenre: @escaping(([String]) -> Void) )
    {
        self.completionHandlerGenre = completionHandlerGenre
        
        getPopularMovieByGenre(genre: genre)
        
    }
    
    public func itemOverview(forSearch ttValue: String, _ completionHandlerOverview: @escaping((Item) -> Void) )
    {
        self.completionHandlerOverview = completionHandlerOverview
        
        getItemOverview(forSearch: ttValue)
        
    }
    
    
    
    public func getPopularMovieByGenre(genre genre: String)
    {
        let headers = [
            "X-RapidAPI-Host": "online-movie-database.p.rapidapi.com",
            "X-RapidAPI-Key": "1e57911e14mshbabefc5bfe92105p139f04jsnf5dfc4400515"
        ]
        
        
        
        let url = URL(string: "https://online-movie-database.p.rapidapi.com/title/v2/get-popular-movies-by-genre?genre=\(genre)&limit=300")
        
    
        
        guard url != nil else {
            print ("Error creating URL object")
            return
        }
        
        //URL Request
        var request = URLRequest(url: url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval:  10)
        
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        //Get the URLSession
        let session = URLSession.shared
        
        //Create the data task
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            
            //Check for errors
            if error == nil && data != nil {
                //Try to parse out the data
                
                do {
                    
                
                    
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    let results = try! decoder.decode([String].self, from: data!)
                    
                    
                    print (results)
                    
                    
                     
                    self.completionHandlerGenre?([String](results))
                    
                    
                }
                catch {
                    print("Error parsing response data")
                }
            }
            
              
            
        }
        
        
        dataTask.resume()
        
    }
    
    
    
    public func getItemBySearch(forSearch search: String){
        
        
        let headers = [
            "X-RapidAPI-Host": "online-movie-database.p.rapidapi.com",
            "X-RapidAPI-Key": "1e57911e14mshbabefc5bfe92105p139f04jsnf5dfc4400515"
        ]
        

        
        let stringFormated = search.replacingOccurrences(of: " ", with: "%20")
                
        
        let url = URL(string: "https://online-movie-database.p.rapidapi.com/auto-complete?q=\(stringFormated)")
        
        // "https://online-movie-database.p.rapidapi.com/title/find?q=\(search)")
        
        guard url != nil else {
            print ("Error creating URL object")
            return
        }
        
        //URL Request
        var request = URLRequest(url: url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval:  10)
        
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        //Get the URLSession
        let session = URLSession.shared
        
        //Create the data task
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            
            //Check for errors
            if error == nil && data != nil {
                //Try to parse out the data
                
                do {
                    
                    
                    if let response = try? JSONDecoder().decode(ResponseAutoComplete.self, from: data!)
                   {
                       self.completionHandler?(Item(response: response))
    
                        //print (response)
                    }
                    
                }
                catch {
                    print("Error parsing response data")
                }
                
            }
        }
        
        
        dataTask.resume()
        
        
        
        
    }
    
    
    
    public func getItemOverview(forSearch ttValue: String){
        
        
        let headers = [
            "X-RapidAPI-Host": "online-movie-database.p.rapidapi.com",
            "X-RapidAPI-Key": "1e57911e14mshbabefc5bfe92105p139f04jsnf5dfc4400515"
        ]
        
        
            
        
        let url = URL(string: "https://online-movie-database.p.rapidapi.com/title/get-overview-details?tconst=\(ttValue)&currentCountry=US")
        
        // "https://online-movie-database.p.rapidapi.com/title/find?q=\(search)")
        
        guard url != nil else {
            print ("Error creating URL object")
            return
        }
        
        //URL Request
        var request = URLRequest(url: url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval:  10)
        
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        //Get the URLSession
        let session = URLSession.shared
        
        //Create the data task
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            
            //Check for errors
            if error == nil && data != nil {
                //Try to parse out the data
                
                do {

                    
                    let response = try! JSONDecoder().decode(ResponseOverview.self, from: data!)
                   

                    self.completionHandlerOverview?(Item(responseOverview: response))

                    
                    
                }
                catch {
                    print("Error parsing response data")
                }
            }
            
              
            
        }
        
        
        dataTask.resume()
        
        
        
        
    }
    
    
}
    
    
    
    //-----FOR Find-------
    
    public struct Response: Decodable
    {
        var results: [results]
        var query: String
        
        
    }
    
    public struct results: Decodable
    {
        var id: String
        var image: image?
        var title: String?
        var seriesEndYear: Int?
        var nextEpisode: String?
        var seriesStartYear: Int?
        var numberOfEpisodes: Int?
        var runningTimeInMinutes: Int?
        
    }
    
    
    public struct image: Decodable
    {
        var height: Int
        var id: String
        var url: String
        var width: Int
    }
    
    //-----For AUTO COMPLETE-----
    public struct ResponseAutoComplete: Decodable
    {
        var d: [resultsAutoComplete]
        var q: String
        
        
    }
    
    public struct resultsAutoComplete: Decodable
    {
        var id: String?
        var i: imageAutoComplete?
        var l: String?
        var rank: Int?
        var s: String?
        var vt: Int?
        var y: Int?
        
        
    }
    
    
    public struct imageAutoComplete: Decodable
    {
        var height: Int
        var imageUrl: String
        var width: Int
    }
    





//-----FOR OverView Details-------

public struct ResponseOverview: Decodable
{
    var id: String?
    var genres: genres?
    var title: title?
    var query: String?
    //var certificates: String?
    var ratings: ratings?
 
    var releaseDate : String?
    var plotSummary: plotSummary?
    
    
    
}

public struct title: Decodable
{
    var id: String?
    var year: Int?
    var image: imageOverview?
    var title: String?
    var seriesEndYear: Int?
    var nextEpisode: String?
    var seriesStartYear: Int?
    var numberOfEpisodes: Int?
    var runningTimeInMinutes: Int?
    var titleType: String?
    
    
}

public struct imageOverview: Decodable
{
    var height: Int?
    var url: String?
    var width: Int?
}

public struct ratings: Decodable
{
    var canRate: Bool?
    var rating: Double?
    var ratingCount: Int?
}

public struct genres: Decodable
{
    
   
}

public struct plotSummary: Decodable
{
    var author: String?
    var text: String?
}


    
    
    
