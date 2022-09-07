//
//  BaseViewController.swift
//  VAKIFBANKAPP
//
//  Created by Bedirhan Altun on 29.08.2022.
//

private class ProgressView: UIView {
    init(){
        super.init(frame: UIScreen.main.bounds)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

import UIKit

class BaseViewController: UIViewController {
    
    let loadingLabel = UILabel(frame: CGRect(x: 160, y: 423, width: 200, height: 50))
    func showProgress(message: String){
        
        let progressView = ProgressView()
        progressView.backgroundColor = .black.withAlphaComponent(0.5)
        progressView.alpha = 0
        
        let loadingIndicator = UIActivityIndicatorView()
        loadingIndicator.center = progressView.center
        loadingIndicator.center.x = 140
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = .medium
        loadingIndicator.startAnimating()
        
        
        loadingLabel.text = message
        loadingLabel.textColor = .black
        loadingLabel.font = UIFont(name: loadingLabel.font.fontName, size: 18)
        
        progressView.addSubview(loadingIndicator)
        progressView.addSubview(loadingLabel)
        
        navigationController?.view.addSubview(progressView)
        UIView.animate(withDuration: 0.5) {
            progressView.alpha = 1
        }
        
    }
    
    func stopProgress(){
        for subview in navigationController?.view.subviews ?? [] where subview is ProgressView  {
            UIView.animate(withDuration: 0.5) {
                subview.alpha = 0
            } completion: { _ in
                subview.removeFromSuperview()
                self.loadingLabel.removeFromSuperview()
            }
            
        }
        
    }
}

