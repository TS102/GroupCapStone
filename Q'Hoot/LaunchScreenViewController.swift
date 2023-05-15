//
//  LaunchScreenViewController.swift
//  Q'Hoot
//
//  Created by Easton Butterfield on 5/15/23.
//

import UIKit
import SwiftUI
class LaunchScreenViewController: UIViewController {
    let contentView = UIHostingController(rootView: BounceAnimationView(text: "Q'Hoot!", startTime: 0.2))
      override func viewDidLoad() {
          
          super.viewDidLoad()
          
          // 2. Start LottieAnimationView with animation name (without extension)
          
          addChild(contentView)
          view.addSubview(contentView.view)
          contentView.view.translatesAutoresizingMaskIntoConstraints = false
          let constraints = [
              contentView.view.topAnchor.constraint(equalTo: view.topAnchor),
              contentView.view.leftAnchor.constraint(equalTo: view.leftAnchor),
              view.bottomAnchor.constraint(equalTo: contentView.view.bottomAnchor),
              view.rightAnchor.constraint(equalTo: contentView.view.rightAnchor)
          ]
          
          NSLayoutConstraint.activate(constraints)
          
          /// Notify the hosting controller that it has been moved to the current view controller.
          contentView.didMove(toParent: self)
          DispatchQueue.main.asyncAfter(deadline:.now() + 4.0, execute: {
             self.performSegue(withIdentifier:"launch",sender: self)
          })
         
      }
    
  }

