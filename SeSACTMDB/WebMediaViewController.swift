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
        print(WebMediaViewController.youtubeNum)
    }
    static var youtubeURL: [Youtube] = []
    static var youtubeAll: [[Youtube]] = []
    static var youtubeNum: Int = 0
    var youtubeString: String = ""
    
    func getYoutube(){
        guard let url = URL(string: "\(EndPoint.youtube2)\(WebMediaViewController.youtubeAll[WebMediaViewController.youtubeNum][0].youtubeURL)") else { return  }
//        print(youtubeAll[youtubeNum][0].youtubeURL)
        let request = URLRequest(url: url)
//        if self.youtubeURL.count - 1 >= self.youtubeNum{ getYoutube() }
        youtubeWebView.load(request)

    }

}
