//
//  PosterView.swift
//  SeSACTMDB
//
//  Created by Y on 2022/08/04.
//

import UIKit

import Kingfisher

class PosterView: UIView {

    @IBOutlet weak var posterImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }

    private func commonInit(){
        let bundle = Bundle.init(for: self.classForCoder)
        let view = bundle.loadNibNamed("PosterView", owner: self, options: nil)?.first as! UIView

        view.frame = self.bounds
        self.addSubview(view)
    }
}


