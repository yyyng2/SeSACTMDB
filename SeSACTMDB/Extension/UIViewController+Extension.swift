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
    
    func transitionViewController<T: UIViewController>(storyboard: String, ViewController vc: T, transitionStyle: TransitionStyle, Handler: @escaping (T) -> ()) {
        let sb = UIStoryboard(name: storyboard, bundle: nil)
        guard let controller = sb.instantiateViewController(withIdentifier: T.reuseIdentifier) as? T else { return }
        Handler(controller)
        switch transitionStyle {
        case .present:
            self.present(controller, animated: true)
        case .push:
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
        
    
}
