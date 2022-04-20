//
//  UIController+presentInView.swift
//  Lenta
//
//  Created by Alexandr Nesterenko on 20.04.22.
//

import Foundation
import UIKit

extension UIViewController {
    
    func present(_ vc: UIViewController, in view: UIView) {
        if let childVC = children.first(where: { child in
            view.subviews.first(where: { $0 == child.view }) != nil
        }) {
            childVC.willMove(toParent: nil)
            childVC.removeFromParent()
            childVC.view.removeFromSuperview()
            childVC.didMove(toParent: nil)
        }
        
        vc.willMove(toParent: self)
        view.addSubview(vc.view)
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            vc.view.topAnchor.constraint(equalTo: view.topAnchor),
            vc.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            vc.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            vc.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        addChild(vc)
        vc.didMove(toParent: self)
    }
    
}
