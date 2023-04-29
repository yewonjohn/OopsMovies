//
//  MovieDetailsPopAnimation.swift
//  OopsMovies
//
//  Created by John Kim on 4/28/23.
//

import Foundation
import UIKit

class MovieDetailsPopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    let duration: TimeInterval = 0.3
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from),
              let toVC = transitionContext.viewController(forKey: .to),
              let snapshot = fromVC.view.snapshotView(afterScreenUpdates: false) else {
            return
        }
        
        let containerView = transitionContext.containerView
        containerView.addSubview(toVC.view)
        containerView.addSubview(snapshot)
        fromVC.view.removeFromSuperview()
        
        snapshot.frame = fromVC.view.frame
        snapshot.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        snapshot.layer.position = CGPoint(x: snapshot.frame.midX, y: snapshot.frame.midY)
        
        let translationTransform = CGAffineTransform(translationX: containerView.frame.maxX - 150, y: -containerView.frame.maxY)
        let rotationTransform = CGAffineTransform(rotationAngle: CGFloat(20 * Double.pi / 180))
        let finalTransform = translationTransform.concatenating(rotationTransform)
        
        UIView.animate(withDuration: duration, animations: {
            snapshot.transform = finalTransform
            toVC.view.alpha = 1
        }) { _ in
            snapshot.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}

//MARK: - MovieDetailsViewController

extension MovieDetailsViewController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationController.Operation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .pop {
            return MovieDetailsPopAnimator()
        } else {
            return nil
        }
    }
}

extension MovieDetailsViewController : UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        // Disable swipe to pop if the current view controller is the root view controller
        return navigationController?.viewControllers.count ?? 0 > 1
    }
}
