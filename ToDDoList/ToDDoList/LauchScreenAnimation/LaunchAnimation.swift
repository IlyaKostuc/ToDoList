//
//  LaunchAnimation.swift
//  ToDDoList
//
//  Created by Maxim Fedoseenko on 15.04.2024.
//

import UIKit
import Lottie

class LaunchAnimation: UIViewController {
    
    private var colorDeafault: UIColor {#colorLiteral(red: 0.3801780305, green: 0.4076312424, blue: 0.4427852878, alpha: 1)}
    var animationView = LottieAnimationView()
    
    lazy var lbl = makeLabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupAnimationView()
        setupConstrins()
        
        view.addSubview(lbl)
        setupLblConstrains()
      
    }
    
    
    private func setupAnimationView() {
        animationView = LottieAnimationView(name: "ppp")
        animationView.loopMode = .playOnce
        animationView.animationSpeed = 2
        
       
        animationView.play { [weak self] finished in
            self?.transitionToMainViewController()
        }
        
        
        view.addSubview(animationView)
    }
    
    
    private func setupConstrins() {
        animationView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            animationView.widthAnchor.constraint(equalToConstant: 300),
            animationView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
    
   
    private func transitionToMainViewController() {
        let mainViewController = TabBar()
        mainViewController.modalPresentationStyle = .automatic
        
       
        if let window = UIApplication.shared.windows.first {
          
            UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: {
               
                window.rootViewController = mainViewController
            })
        }
    }
    
}

extension LaunchAnimation {
    private func makeLabel() -> UILabel {
        let label = UILabel()
        label.text = "© 2011-2024 Path. All rights reserved"
        label.textColor = colorDeafault
        label.font = UIFont.systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
       
        return label
    }
    
    private func setupLblConstrains() {
        NSLayoutConstraint.activate([
            lbl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            lbl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            
        ])
    }
}



