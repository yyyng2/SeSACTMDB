//
//  CardView.swift
//  SeSACTMDB
//
//  Created by Y on 2022/08/09.
//

import UIKit

class CardView: UIView {

    @IBOutlet weak var posterImageView: UIImageView!
  
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        let view = UINib(nibName: "CardView", bundle: nil).instantiate(withOwner: self).first as! UIView
        //first -> nib안의 여러 뷰중에 몇번째 인지 구분하는 것
        view.frame = bounds
        view.backgroundColor = .lightGray
        self.addSubview(view)
        //뷰를 추가해달라.
    }
    
}
