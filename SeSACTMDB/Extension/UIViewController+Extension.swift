//
//  UIViewController+Extension.swift
//  SeSACTMDB
//
//  Created by Y on 2022/08/18.
//

import UIKit

extension UIViewController{
    
    enum TransitionStyle{
        case present
        case push
    }
    
    func transitionViewController<T: UIViewController>(storyboard: String, ViewController vc: T, transitionStyle: TransitionStyle) {
        let sb = UIStoryboard(name: storyboard, bundle: nil)
        
        switch transitionStyle {
        case .present:
            guard let controller = sb.instantiateViewController(withIdentifier: T.reuseIdentifier) as? T else { return }
            self.present(controller, animated: true)
        case .push:
            guard let controller = sb.instantiateViewController(withIdentifier: T.reuseIdentifier) as? T else { return }
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
        
    
}
