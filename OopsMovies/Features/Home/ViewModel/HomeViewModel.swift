//
//  HomeViewModel.swift
//  OopsMovies
//
//  Created by John Kim on 4/28/23.
//

import Foundation
import UIKit

protocol HomeViewModelProtocol {
    func fetchMovies() -> [Movie]
    func navigateToMovieDetails(navigationController: UINavigationController?, movie: Movie, backgroundColor: [CGColor])
}

class HomeViewModel : HomeViewModelProtocol {
    
    let homeService : HomeServiceProtocol
    
    init(homeService: HomeServiceProtocol) {
        self.homeService = homeService
    }
    
    func fetchMovies() -> [Movie] {
        return homeService.fetchMovies()
    }
    
    func navigateToMovieDetails(navigationController: UINavigationController?, movie: Movie, backgroundColor: [CGColor]) {
        let viewController = MovieDetailsViewController(viewModel: MovieDetailsViewModel(), movieTitle: movie.title, backdropImage: movie.backdropImage, posterImage: movie.posterImage, posterTitle: movie.posterTitle, attributes: movie.attributes, titleDescription: movie.description, backgroundColor: backgroundColor)
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
}
