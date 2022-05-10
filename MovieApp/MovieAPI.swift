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
    private var completionHandlerGenre: ((ItemGenre) -> Void)?
    
    //@Published var item: ResponseGenre =
    
    
    public func searchItem(forSearch name: String, _ completionHandler: @escaping((Item) -> Void) )
    {
        self.completionHandler = completionHandler
        
        getItemBySearch(forSearch: name)
        
    }
    
    public func randomMoviePopularGenre(forSearch genre: String, _ completionHandlerGenre: @escaping((ItemGenre) -> Void) )
    {
        self.completionHandlerGenre = completionHandlerGenre
        
        getPopularMovieByGenre(genre: genre)
        
    }
    
    
    
    public func getPopularMovieByGenre(genre genre: String)
    {
        let headers = [
            "X-RapidAPI-Host": "online-movie-database.p.rapidapi.com",
            "X-RapidAPI-Key": "8fea44c8demsh89f1b4fa02718e9p1f604cjsnbe769d1e747f"
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
        let dataTask = session.dataTask(with: request) {[weak self ]data, response, error in
            
            //Check for errors
            if error == nil && data != nil {
                //Try to parse out the data
                
                do {
                    
                    
                                        
                    if let response = try? JSONDecoder().decode(ResponseGenre.self, from: data!)
                                       {
                                           self?.completionHandlerGenre?(ItemGenre(response: response))
                        
                        print (response)
                    }
                    
//                    
//                    let dictionary = try JSONSerialization.jsonObject(with: data!) as! [String:Any]
//                    print (dictionary)
//                    let response = try! JSONDecoder().decode(ResponseGenre.self, from: data!)
//                    print (response)
////                    DispatchQueue.main.async {
////                        self?.item = response
////                    }
                    
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
            "X-RapidAPI-Key": "8fea44c8demsh89f1b4fa02718e9p1f604cjsnbe769d1e747f"
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
        var results: [String]
        
    }
    
    
    
