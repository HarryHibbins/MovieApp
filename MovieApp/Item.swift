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

    
    init(response: Response) {
        
        title = response.results.first?.title ?? ""
        year = response.results.first?.seriesStartYear
        
        imageURL = response.results.first?.image?.url ?? ""

        
    }
    
    init(response: ResponseAutoComplete) {
        
        title = response.d.first?.l ?? ""
        year = response.d.first?.y
        
        imageURL = response.d.first?.i?.imageUrl ?? ""

        
    }
}


