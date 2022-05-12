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
    private var completionHandlerGenre: ((Item) -> Void)?
    private var completionHandlerOverview: ((Item) -> Void)?
    
    //@Published var item: ResponseGenre =
    @Published var genreResults: [String] = []
    
    
    public func searchItem(forSearch name: String, _ completionHandler: @escaping((Item) -> Void) )
    {
        self.completionHandler = completionHandler
        
        getItemBySearch(forSearch: name)
        
    }
    
    public func randomMoviePopularGenre(forSearch genre: String, _ completionHandlerGenre: @escaping((Item) -> Void) )
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
            "X-RapidAPI-Key": "a0aad0a9fbmsha0bd8cd04b9b778p1a5d24jsnb64d0144111c"
        ]
        
        
        
        let url = URL(string: "https://online-movie-database.p.rapidapi.com/title/v2/get-popular-movies-by-genre?genre=\(genre)&limit=100")
        
    
        
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

    
                    let httpResponse = response as? HTTPURLResponse
                            print(httpResponse)

                    
                    
                    let dictionary = try! JSONSerialization.jsonObject(with: data!)
                    
                    print (dictionary)
                    
                    
                    
                    
                    var jsonString = ""
                    //self.genreResults = dictionary as! [String]
                    
                    
                    for (key) in dictionary as! [String]{
                        print("\(key)  ")
                        jsonString += key
                        
                        print ("RESULTS: " , key)
                        
                    }
                    
                    for result in dictionary as! [String]
                    {
                        self.genreResults.append(result)
                        print ("append" , result)
                    }
                    
//                 
//                    let jsonData = try! JSONEncoder().encode(jsonString)
//                    let jsonString_ = String(data: jsonData, encoding: .utf8)!
//
//                    print( "JSON DATA" , jsonString_
//                    
//                    )
//                    //var result = ResponseGenre.init(result: jsonString)
//                    
//                    let response = try! JSONDecoder().decode([ResponseGenre].self, from: jsonData)
                   
                  //  self.completionHandlerGenre?(Item(responseGenre: response))

                    
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
            "X-RapidAPI-Key": "a0aad0a9fbmsha0bd8cd04b9b778p1a5d24jsnb64d0144111c"
        ]
        
        
        let stringFormated = search.replacingOccurrences(of: " ", with: "%")
        
        
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
            "X-RapidAPI-Key": "a0aad0a9fbmsha0bd8cd04b9b778p1a5d24jsnb64d0144111c"
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

                    print (response)
                    
                    
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
    
    
    //-----FOR GENRE------
    public struct ResponseGenre: Decodable
    {
        let result: String
    //    let StringArray: [String]
        
//        public init(from decoder: Decoder) throws {
//                var container = try decoder.unkeyedContainer()
//                firstString = try container.decode(String.self)
//                StringArray = try container.decode([String].self)
//            }
        
        
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
    var height: Int
    var url: String
    var width: Int
}

public struct ratings: Decodable
{
    var canRate: Bool
    var rating: Double
    var ratingCount: Int
}

public struct genres: Decodable
{
    
   
}

public struct plotSummary: Decodable
{
    var author: String?
    var text: String
}


    
    
    
