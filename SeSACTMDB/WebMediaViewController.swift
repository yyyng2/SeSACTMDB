//
//  WebMediaViewController.swift
//  SeSACTMDB
//
//  Created by Y on 2022/08/07.
//

import UIKit

import WebKit

class WebMediaViewController: UIViewController {

    static var identifier = "WebMediaViewController"
    
    @IBOutlet weak var youtubeWebView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
//        if self.youtubeAll.count - 1 >= self.youtubeNum{ self.getYoutube() }
//        print("\(youtubeAll)aasdf")
        getYoutube()
        
        
    }
    var youtubeURL: [Youtube] = []
    var youtubeAll: [[Youtube]] = []
    var youtubeNum: Int = 0
    var youtubeString: String = ""
    var youtubeHandler: ((String) -> (String))?
    
    func getYoutube(){
        
//        let vc = WebMediaViewController()
//        let vc2 = TrendViewController()
        
//        vc.youtubeHandler = {
//            self.youtubeNum = vc2.sendertag
//        }
        
        guard let url = URL(string: "\(EndPoint.youtube2)\(self.youtubeAll[youtubeNum][0].youtubeURL)") else { return }

//        print(youtubeAll[youtubeNum][0].youtubeURL)
        let request = URLRequest(url: url)
//        if self.youtubeURL.count - 1 >= self.youtubeNum{ getYoutube() }
        youtubeWebView.load(request)

    }

}
