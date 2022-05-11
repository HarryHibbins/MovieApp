//
//  Item.swift
//  MovieApp
//
//  Created by Harrison Hibbins on 08/05/2022.
//

import Foundation
import SwiftUI


public struct Item {
    let title: String
    let year: Int?
    let imageURL: String
    let releaseDate: String?
    


    
    init(response: Response) {
        
        title = response.results.first?.title ?? ""
        year = response.results.first?.seriesStartYear
        releaseDate = ""
        imageURL = response.results.first?.image?.url ?? ""

        
    }
    
    init(response: ResponseAutoComplete) {
        
        title = response.d.first?.l ?? ""
        year = response.d.first?.y
        releaseDate = ""
        imageURL = response.d.first?.i?.imageUrl ?? ""
        
        for index in 0..<response.d.count
        {
            let titles = response.d[index].l
            let years = response.d[index].y
            let imageUrls = response.d[index].i?.imageUrl
            print (titles, years)
        }
        
    }
            
            
    init(responseOverview: ResponseOverview) {
                
        title = responseOverview.title?.title ?? ""
        year = 0
        
        releaseDate = responseOverview.releaseDate
        
        imageURL = responseOverview.title?.image?.url ?? ""
                
        //        title = response.results.first?.title ?? ""
        //
        //
        //        var id: String
        //        var title: title
        //        var query: String
        //        var certificates: String
        //        var ratings: ratings
        //        var genres: genres
        //        var releaseDate : String
        //        var plotSummary: plotSummary
                
            }
    
        
        
        

        


  
}

public struct ItemGenre {
    let title: String
    


    init(response: ResponseGenre) {

        //title = (response.results)!

        title = response.results[0]
    }
}



    


    
    
    
    




