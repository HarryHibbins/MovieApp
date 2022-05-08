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
    let imageURL: String

    
    init(response: Response) {
        
        title = response.results.first?.title ?? ""
        id = response.results.first?.id ?? ""
        imageURL = response.results.first?.image?.url ?? ""

        
    }
}
