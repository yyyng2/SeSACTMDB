//
//  TrendDetailViewController.swift
//  SeSACTMDB
//
//  Created by Y on 2022/08/04.
//

import UIKit

import Kingfisher

class TrendDetailViewController: UIViewController {
    
    var movieDetail: [Movie] = []
    
    @IBOutlet weak var backImageView: UIImageView!
    static let identifier = "TrendDetailViewController"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        designDetail()
        
        
    }
    
    func designDetail(){
        let index = UserDefaults.standard.integer(forKey: "index")
        let urlPlus = "https://www.themoviedb.org/t/p/w1280/\(movieDetail[index].movieBackground)"
        guard let url = URL(string: urlPlus) else { return }
        backImageView.kf.setImage(with: url)
    }
    



}
