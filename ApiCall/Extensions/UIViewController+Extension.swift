//
//  UIViewController+Extension.swift
//  ApiCall
//
//  Created by Arshad Shaik on 31/10/25.
//

import UIKit

extension ViewController {
    func showLoader() {
        DispatchQueue.main.async {
            self.activityIndicatorView.color = .green
            self.view.addSubview(self.activityIndicatorView)
            self.activityIndicatorView.center = self.view.center
            self.activityIndicatorView.startAnimating()
            print("Is Loading ", self.activityIndicatorView.isAnimating)
        }
    }
    
    func defaultActivityIndicatorView() -> UIActivityIndicatorView {
        let activityIndicatorView = UIActivityIndicatorView(style: .large)
        activityIndicatorView.color = .label
        return activityIndicatorView
    }
    
    func hideLoader() {
        DispatchQueue.main.async {
            self.activityIndicatorView.stopAnimating()
        }
    }
}
