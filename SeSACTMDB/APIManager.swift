//
//  APIManager.swift
//  SeSACTMDB
//
//  Created by Y on 2022/08/08.
//

import Foundation
import Alamofire
import SwiftyJSON

class TrendAPIManager{
    static let shared = TrendAPIManager()
    
    init (){}
    
    func getMedia(startPage: Int, completionHandler: @escaping (JSON) -> ()){
        
        let url = "\(EndPoint.tmdbURL)api_key=\(APIKey.TMDBKEY)&page=\(startPage)"
        
        AF.request(url, method: .get).validate(statusCode: 200..<300).responseData { response in
            switch response.result{
            case .success(let value):
                let json = JSON(value)

                completionHandler(json)

            case .failure(let error):
                print(error)
                
            }
        }
    }
}

class CreditsAPIManager{
    static let shared = CreditsAPIManager()
    init () {}
    
    func getCasts(movieList: [Movie], completionHandler: @escaping (JSON) -> ()){
        for i in 0...(movieList.count - 1){
            let url = "\(EndPoint.castsURL)\(movieList[i].movieID)/credits?api_key=\(APIKey.TMDBKEY)"

            AF.request(url, method: .get).validate(statusCode: 200..<300).responseData { response in
                switch response.result{
                case .success(let value):
                    let json = JSON(value)
                    
                    completionHandler(json)

                case .failure(let error):
                    print(error)

                }
            }

        }
    }
}

class YoutubeAPIManager{
    static let shared = YoutubeAPIManager()
    init(){}
    
    func getYoutubeURL(movieList: [Movie], completionHandler: @escaping (JSON) -> ()){
        for i in 0...(movieList.count - 1){
            let url = "\(EndPoint.youtubeURL)\(movieList[i].movieID)/videos?api_key=\(APIKey.TMDBKEY)&language=en-US"

            AF.request(url, method: .get).validate(statusCode: 200..<300).responseData { response in
                switch response.result{
                case .success(let value):
                    let json = JSON(value)
                    completionHandler(json)

                case .failure(let error):
                    print(error)

                }
            }

        }
    }
}
