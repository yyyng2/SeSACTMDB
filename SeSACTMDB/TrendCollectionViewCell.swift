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
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var rateView: UIView!
    @IBOutlet weak var rateTextLabel: UILabel!
    @IBOutlet weak var rateValueLabel: UILabel!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieCredtisLabel: UILabel!
    @IBOutlet weak var showDetailLabel: UILabel!
    @IBOutlet weak var showdetailImageView: UIImageView!
    @IBOutlet weak var blackLineView: UIView!
    @IBOutlet weak var clipView: UIView!
    @IBOutlet weak var clipButton: UIButton!
    
    func cellConfigure(){
        posterView.layer.cornerRadius = 10
        posterView.layer.cornerRadius = 10
        posterView.clipsToBounds = true
        posterView.backgroundColor = .clear
        posterView.layer.masksToBounds = true
        posterView.layer.cornerRadius = 10
        rateView.layer.shadowOpacity = 0.8
        rateView.layer.shadowOffset = CGSize(width: 2, height: 2)
        rateView.layer.shadowRadius = 5
        infoView.layer.cornerRadius = 10
        infoView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        rateTextLabel.layer.cornerRadius = 5
        rateTextLabel.clipsToBounds = true
        rateTextLabel.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        rateValueLabel.layer.cornerRadius = 5
        rateValueLabel.clipsToBounds = true
        rateValueLabel.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        posterView.contentMode = .scaleAspectFill
        infoView.backgroundColor = .white
        rateTextLabel.textAlignment = .center
        rateTextLabel.textColor = .white
        rateTextLabel.backgroundColor = .black
        rateValueLabel.textAlignment = .center
        rateValueLabel.backgroundColor = .white
        clipButton.backgroundColor = .clear
        clipButton.tintColor = .black
        clipButton.contentMode = .scaleAspectFit
        clipView.backgroundColor = .white
        clipView.layer.cornerRadius = clipView.frame.width / 2
        showdetailImageView.tintColor = .black
        blackLineView.backgroundColor = .black
        movieCredtisLabel.textColor = .systemGray
    }
    
}
