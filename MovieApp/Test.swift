//
//  Test.swift
//  MovieApp
//
//  Created by Harrison Hibbins on 07/05/2022.
//

import Foundation
public final class CardAPI : NSObject


{

    public override init(){

        

        super.init()


        let headers = [


            "X-RapidAPI-Host": "omgvamp-hearthstone-v1.p.rapidapi.com",


            "X-RapidAPI-Key": "5e1fb5e5aamsh8e6f1fcb59b851fp105ce1jsn97cecb7b6760"


        ]


        let url = URL(string: "https://omgvamp-hearthstone-v1.p.rapidapi.com/cards/Pupbot?locale=US")

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


                    let dictionary = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [String:Any]


                    print ("TEST", dictionary)

                }

                catch {

                    print("Error parsing response data")

                }

            }

        }

        dataTask.resume()

    }

}
