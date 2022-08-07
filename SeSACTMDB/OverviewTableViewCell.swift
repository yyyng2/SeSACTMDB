//
//  OverviewTableViewCell.swift
//  SeSACTMDB
//
//  Created by Y on 2022/08/06.
//

import UIKit

import Alamofire
import Kingfisher
import SwiftyJSON

class OverviewTableViewCell: UITableViewCell {

    @IBOutlet weak var overviewLabel: UILabel!
    static let identifier = "OverviewTableViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
