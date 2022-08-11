//
//  CardCollectionViewCell.swift
//  SeSACTMDB
//
//  Created by Y on 2022/08/09.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cardView: CardView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    func setupUI(){
        cardView.backgroundColor = .clear
        cardView.posterImageView.backgroundColor = .yellow
    }
}
