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
    
    public override init(){

        super.init()

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
                    let dictionary = try JSONSerialization.jsonObject(with: data!) as! [String:Any]

                    
                    for item in dictionary {
                        //print("New Item ------ ", item)
                    }
                    
                    for (key, value) in dictionary {
                        //print("\(key) - \(value) ")
                       
                        
              
                    }
                    /* if (key == "results")
                     {
                         
                         print ("VALUE: ", value)
      
                     }
                     
                     for (object) in dictionary
                     {
                         print ("object",object)
                     }
                     
                     for (title) in dictionary
                     {
                         print ("title",title)
                     }*/
                     
                     for (image) in dictionary
                     {
                         print ("image",image)
                     }
                    //https://developer.apple.com/swift/blog/?id=37 using this for help
//                    if let nestedDictionary = dictionary["results"] as? [String: Any] {
//                        // access nested dictionary values by key
//                        print("Found TITLE")
//                    }
                }
                catch {
                    print("Error parsing response data")
                }
                
            }
        }
        
      
        dataTask.resume()

         
    }
     
   
    

}

