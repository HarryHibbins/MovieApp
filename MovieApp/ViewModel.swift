//
//  ViewModel.swift
//  MovieApp
//
//  Created by Harrison Hibbins on 08/05/2022.
//

import Foundation

public class ViewModel: ObservableObject {
    @Published var id: String = "ID"
    @Published var title: String = "Title"
    @Published var Image: String = "--"
    
    
    public let movieAPI: MovieAPI
    
    public init(movieAPI: MovieAPI) {
        self.movieAPI = movieAPI
    }
    
    public func refresh(forSearch name: String) {
        
        movieAPI.search(forSearch: name) { movie in DispatchQueue.main.async {
            self.id = movie.id
            self.title = movie.title
            self.Image = movie.imageURL
        }}
    }
}
