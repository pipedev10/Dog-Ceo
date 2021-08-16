//
//  LoadingViewController.swift
//  Dog-Ceo-Challenge
//
//  Created by Pipe Carrasco on 15-08-21.
//

import UIKit

class LoadingViewController: UIViewController {
    // MARK: - Properties
    var loadingActivityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .gray
        indicator.color = .white
        indicator.startAnimating()
        indicator.autoresizingMask = [
            .flexibleLeftMargin, .flexibleRightMargin,
            .flexibleTopMargin, .flexibleBottomMargin
        ]
        return indicator
    }()
    
    var blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.alpha = 0.8
        blurEffectView.autoresizingMask = [
            .flexibleWidth, .flexibleHeight
        ]
        return blurEffectView
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        modalPresentationStyle = .fullScreen
        modalTransitionStyle = .crossDissolve
        blurEffectView.frame = self.view.bounds
        view.insertSubview(blurEffectView, at: 0)
        loadingActivityIndicator.center = CGPoint(
            x: view.bounds.midX,
            y: view.bounds.midY
        )
        view.addSubview(loadingActivityIndicator)
    }
}
