//
//  ViewModel.swift
//  MovieApp
//
//  Created by Harrison Hibbins on 08/05/2022.
//

import Foundation

public class ViewModel: ObservableObject {
    @Published var title: String = "Title"
    @Published var year: Int = 0
    @Published var Image: String = "--"
    
    
    public let movieAPI: MovieAPI
    
    public init(movieAPI: MovieAPI) {
        self.movieAPI = movieAPI
    }
    
    public func refresh(forSearch name: String) {
        
        movieAPI.searchItem(forSearch: name) { movie in DispatchQueue.main.async {
            self.title = movie.title
            self.year = movie.year ?? 00
            self.Image = movie.imageURL
        }}
    }
    
    public func refreshMovieGenre(forSearch genre: String) {
        
        movieAPI.randomMoviePopularGenre(forSearch: genre) { movie in DispatchQueue.main.async {
            self.title = movie.title
            self.year = movie.year ?? 00
            self.Image = movie.imageURL
        }}
    }
}
