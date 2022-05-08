//
//  ViewModel.swift
//  MovieApp
//
//  Created by Harrison Hibbins on 08/05/2022.
//

import Foundation

import Foundation

private let title = "title"


public class ViewModel: ObservableObject {
    @Published var id: String = "ID"
    @Published var title: String = "Title"
    @Published var Image: String = "--"
    
    
    public let movieAPI: MovieAPI
    
    public init(movieAPI: MovieAPI) {
        self.movieAPI = movieAPI
    }
    
    public func refresh() {
        movieAPI.getMovie() { movie in DispatchQueue.main.async {
            self.id = movie
            self.temperature = "\(weather.temperature)°C"
            self.weatherDescription = weather.description//.capitalized
            self.weatherIcon = iconImage[weather.iconName] ?? defaultIcon
        }}
    }
}
