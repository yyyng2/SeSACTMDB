//
//  CastTableViewCell.swift
//  SeSACTMDB
//
//  Created by Y on 2022/08/05.
//

import UIKit

class CastTableViewCell: UITableViewCell {

    static let identifier = "CastTableViewCell"
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var castNameLabel: UILabel!
    @IBOutlet weak var charNameLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
