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
    
    private var completionHandler: ((Response) -> Void)?
    
    public func getMovie(_ completionHandler: @escaping((Item) -> Void)){

      
        let headers = [
            "X-RapidAPI-Host": "online-movie-database.p.rapidapi.com",
            "X-RapidAPI-Key": "102e089728msh794c597386f9554p171b9cjsn2700d9dce773"
        ]

        
        let url = URL(string: "https://online-movie-database.p.rapidapi.com/title/find?q=game%20of%20thr")

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
//                    //USE THIS FOR PRINTING ENTIRE DICTIOANRY
//                    let dictionary = try JSONSerialization.jsonObject(with: data!) as! [String:Any]
//                    for (key, value) in dictionary {
//                        print("KEY: \(key) - \(value) ")
//
//                    }
                    
                    let response = try! JSONDecoder().decode(Response.self, from: data!)
                    
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



public struct Response: Codable
{
    var results: [results]
    var query: String
    
   
}

public struct results: Codable
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


public struct image: Codable
{
    var height: Int
    var id: String
    var url: String
    var width: Int
}
