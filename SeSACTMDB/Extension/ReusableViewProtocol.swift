//
//  ReusableViewProtocol.swift
//  SeSACTMDB
//
//  Created by Y on 2022/08/18.
//

import UIKit

protocol ReuseIdentifierProtocol {
    static var reuseIdentifier: String { get }
}

extension UIViewController: ReuseIdentifierProtocol {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReuseIdentifierProtocol {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell: ReuseIdentifierProtocol {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
