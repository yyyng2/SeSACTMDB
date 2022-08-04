//
//  TrendCollectionViewCell.swift
//  SeSACTMDB
//
//  Created by Y on 2022/08/04.
//

import UIKit

class TrendCollectionViewCell: UICollectionViewCell {
    static let identifier = "TrendCollectionViewCell"
    @IBOutlet weak var releaseLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var posterView: PosterView!
    @IBOutlet weak var rateView: UIView!
    @IBOutlet weak var rateTextLabel: UILabel!
    @IBOutlet weak var rateValueLabel: UILabel!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieCredtisLabel: UILabel!
    @IBOutlet weak var blackLineView: UIView!
    @IBOutlet weak var showDetailButton: UIButton!

    
    @IBAction func showDetailButtonTapped(_ sender: UIButton) {
    }
}