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
    let id: String
    let year: Int?
    let imageURL: String
    let releaseDate: String?
    let author: String?
    let description: String?
    let runningTime: Int?
    
    var IDArray: [String] = []

    
    init(response: Response) {
        
        title = response.results.first?.title ?? ""
        year = response.results.first?.seriesStartYear
        releaseDate = ""
        imageURL = response.results.first?.image?.url ?? ""
        id = ""
        author = ""
        description = ""
        runningTime = 0
        
    }
    
    init(response: ResponseAutoComplete) {
        
        title = response.d.first?.l ?? ""
        year = response.d.first?.y
        releaseDate = ""
        imageURL = response.d.first?.i?.imageUrl ?? ""
        id = response.d.first?.id ?? ""
        runningTime = 0

        author = ""
        description = ""
        if (response.d.count > 1)
        {
            for index in 0..<response.d.count
            {
                let titles = response.d[index].l
                let years = response.d[index].y
                let imageUrls = response.d[index].i?.imageUrl
                IDArray.append(response.d[index].id ?? "")
            }
        }

        
    }
            
            
    init(responseOverview: ResponseOverview) {
                
        title = responseOverview.title?.title ?? ""
        year = 0
        
        releaseDate = responseOverview.releaseDate
        
        imageURL = responseOverview.title?.image?.url ?? ""
        id = responseOverview.title?.id ?? ""
        author = responseOverview.plotSummary?.author
        description = responseOverview.plotSummary?.text
        runningTime = responseOverview.title?.runningTimeInMinutes
        
                
            }
    
    
        
   
    
    
        
        
        

        


  
}


    


    
    
    
    




