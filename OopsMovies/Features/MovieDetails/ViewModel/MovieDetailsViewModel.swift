//
//  MovieDetailsViewModel.swift
//  OopsMovies
//
//  Created by John Kim on 4/28/23.
//

import Foundation
import UIKit

protocol MovieDetailsViewModelProtocol {
    func shareMovie(navigationController : UINavigationController?, toShare: [Any])
    func handlePan(_ view: UIView, navigationController : UINavigationController?, gesture: UIPanGestureRecognizer)
}

class MovieDetailsViewModel : MovieDetailsViewModelProtocol {
    
    func shareMovie(navigationController : UINavigationController?, toShare: [Any]) {
        let activityViewController = UIActivityViewController(activityItems: toShare, applicationActivities: nil)
        navigationController?.present(activityViewController, animated: true, completion: nil)
    }
    
    func handlePan(_ view: UIView, navigationController : UINavigationController?, gesture: UIPanGestureRecognizer) {
        guard let navController = navigationController else { return }

        switch gesture.state {
        case .began:
            let isSwipingRight = gesture.velocity(in: view).x > 0
            if isSwipingRight && navController.viewControllers.count > 1 {
                navController.popViewController(animated: true)
            }
        default:
            break
        }
    }
}
