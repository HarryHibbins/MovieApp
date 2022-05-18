

import SwiftUI

@main
struct MovieAppApp: App {
    var body: some Scene {
        WindowGroup {
            let movieAPI = MovieAPI()
            let viewModel = ViewModel(movieAPI: movieAPI)
            let watchListViewModel = ViewModel(movieAPI: movieAPI)

          ContentView(viewModel: viewModel, watchListViewModel: watchListViewModel)
         
            
            
           
        }
    }
}
