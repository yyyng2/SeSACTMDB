//
//  TrendViewController.swift
//  SeSACTMDB
//
//  Created by Y on 2022/08/04.
//

import UIKit

import Alamofire
import Kingfisher
import SwiftyJSON

class TrendViewController: UIViewController {

    @IBOutlet weak var trendCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        viewConfigure()
        getMedia()
        designSearchBar()

    }
    
    var handler: ((String) -> (String))?

    var movieList: [Movie] = []
    var crewList: [Credits] = []
    var castList: [Casts] = []
    var castAll: [[Casts]] = []
    var crewAll: [[Credits]] = []
    var youtubeURL: [Youtube] = []
    var youtubeAll: [[Youtube]] = []
    var startPage = 1
    var totalPage = 1000

    
    func designSearchBar(){
        //서치바 네비게이션바에 넣기
//        let bounds = UIScreen.main.bounds
//        let width = bounds.size.width
//        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: width - 28, height: 0))
//        searchBar.placeholder = "Place holder"
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: searchBar)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", image: UIImage(systemName: "list.triangle"))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "", image: UIImage(systemName: "magnifyingglass"))
                                                                // , primaryAction: <#T##UIAction?#>, menu: <#T##UIMenu?#>)
    }
    
    func viewConfigure(){
        trendCollectionView.delegate = self
        trendCollectionView.dataSource = self
        trendCollectionView.prefetchDataSource = self
        
        trendCollectionView.layer.cornerRadius = 10
        trendCollectionView.clipsToBounds = true
        let layer = UICollectionViewFlowLayout()
        let spacing: CGFloat = 4
        let witdh = UIScreen.main.bounds.width - (spacing * 2)
        layer.itemSize = CGSize(width: witdh, height: witdh * 1.2)
        layer.scrollDirection = .vertical
        layer.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layer.minimumLineSpacing = spacing
        layer.minimumInteritemSpacing = spacing
        trendCollectionView.collectionViewLayout = layer
    }
 
    func getMedia(){
        
        TrendAPIManager.shared.getMedia(startPage: startPage) { json in
            for data in json["results"].arrayValue{

                let name = data["original_title"].stringValue
                let id = data["id"].intValue
                let release = data["release_date"].stringValue
                let vote = data["vote_average"].doubleValue
                let poster = data["poster_path"].stringValue
                let overView = data["overview"].stringValue
                let backPoster = data["backdrop_path"].stringValue
                let genreNum = data["genre_ids"][0].intValue
    
                guard let rawValue = Genre(rawValue: genreNum) else { return }
                let genre = "\(rawValue)"

                self.movieList.append(Movie(movieName: name, movieID: id, movieRelease: release, moviePoster: poster, movieVoteAverage: vote, movieGenre: genre, movieBackground: backPoster, overView: overView))
                
            }
            self.getYoutubeURL()
            self.getCasts()
        }
        
//        let url = "\(EndPoint.tmdbURL)api_key=\(APIKey.TMDBKEY)&page=\(startPage)"
//
//        AF.request(url, method: .get).validate(statusCode: 200..<300).responseData { response in
//            switch response.result{
//            case .success(let value):
//                let json = JSON(value)
//
//
//                for data in json["results"].arrayValue{
//
//                    let name = data["original_title"].stringValue
//                    let id = data["id"].intValue
//                    let release = data["release_date"].stringValue
//                    let vote = data["vote_average"].doubleValue
//                    let poster = data["poster_path"].stringValue
//                    let overView = data["overview"].stringValue
//                    let backPoster = data["backdrop_path"].stringValue
//                    let genreNum = data["genre_ids"][0].intValue
//
//                    guard let rawValue = Genre(rawValue: genreNum) else { return }
//                    let genre = "\(rawValue)"
//
//                    self.movieList.append(Movie(movieName: name, movieID: id, movieRelease: release, moviePoster: poster, movieVoteAverage: vote, movieGenre: genre, movieBackground: backPoster, overView: overView))
//
//                }
//                self.getYoutubeURL()
//                self.getCasts()
//            case .failure(let error):
//                print(error)
//
//            }
//        }
    }
  
    func getCasts(){
        
        CreditsAPIManager.shared.getCasts(movieList: movieList) { json in
            self.castList.removeAll()
            
            
            for data in json["cast"].arrayValue{
                
                let castName = data["name"].stringValue
                let castProfile = data["profile_path"].stringValue
                let char = data["character"].stringValue
                
                self.castList.append(Casts(castName: castName, character: char, profile: castProfile))
                
            }
            self.castAll.append(self.castList)
        }
        
        CreditsAPIManager.shared.getCasts(movieList: movieList) { json in
            self.crewList.removeAll()
            
            for data in json["crew"].arrayValue{

                let crewName = data["name"].stringValue
                let crewProfile = data["profile_path"].stringValue
                let job = data["department"].stringValue

                self.crewList.append(Credits(crewName: crewName, job: job, profile: crewProfile))
            }
            self.crewAll.append(self.crewList)

        }
        
//        for i in 0...(movieList.count - 1){
//            let url = "\(EndPoint.castsURL)\(movieList[i].movieID)/credits?api_key=\(APIKey.TMDBKEY)"
//
//            AF.request(url, method: .get).validate(statusCode: 200..<300).responseData { response in
//                switch response.result{
//                case .success(let value):
//                    self.castList.removeAll()
//                    self.crewList.removeAll()
//                    let json = JSON(value)
//                    //print("JSON: \(json)")
//
//                    for data in json["cast"].arrayValue{
//
//                        let castName = data["name"].stringValue
//                        let castProfile = data["profile_path"].stringValue
//                        let char = data["character"].stringValue
//
//                        self.castList.append(Casts(castName: castName, character: char, profile: castProfile))
//
//                    }
//                    self.castAll.append(self.castList)
//
//                    for data in json["crew"].arrayValue{
//
//                        let crewName = data["name"].stringValue
//                        let crewProfile = data["profile_path"].stringValue
//                        let job = data["department"].stringValue
//
//                        self.crewList.append(Credits(crewName: crewName, job: job, profile: crewProfile))
//                    }
//                    self.crewAll.append(self.crewList)
//
//                }
//            }
//
//        }
    }
    
    func getYoutubeURL(){
        
        YoutubeAPIManager.shared.getYoutubeURL(movieList: movieList) { json in
            self.youtubeURL.removeAll()

            for data in json["results"].arrayValue{

                if data["site"].stringValue == "YouTube"{
                    let videoKey = data["key"].stringValue
                    self.youtubeURL.append(Youtube(youtubeURL: videoKey))
                }

            }
            self.youtubeAll.append( self.youtubeURL)
            self.trendCollectionView.reloadData()
        }
        
//        for i in 0...(movieList.count - 1){
//            let url = "\(EndPoint.youtubeURL)\(movieList[i].movieID)/videos?api_key=\(APIKey.TMDBKEY)&language=en-US"
//
//            AF.request(url, method: .get).validate(statusCode: 200..<300).responseData { response in
//                switch response.result{
//                case .success(let value):
//                    self.youtubeURL.removeAll()
//
//                    let json = JSON(value)
//                    print(json["results"].arrayValue)
//
//                    for data in json["results"].arrayValue{
//
//
//                        if data["site"].stringValue == "YouTube"{
//                            let videoKey = data["key"].stringValue
//                            self.youtubeURL.append(Youtube(youtubeURL: videoKey))
//                        }
//
//                    }
//                    self.youtubeAll.append( self.youtubeURL)
//
//                    self.trendCollectionView.reloadData()
//
//                case .failure(let error):
//                    print(error)
//
//                }
//            }
//
//        }
    }
    
}


extension TrendViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList.count
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrendCollectionViewCell.identifier, for: indexPath) as? TrendCollectionViewCell else { return UICollectionViewCell() }
        cell.cellConfigure()
        cell.backgroundColor = .clear
        cell.releaseLabel.text = movieList[indexPath.item].movieRelease
        cell.releaseLabel.font = .systemFont(ofSize: 13)
        cell.releaseLabel.textColor = .systemGray
        cell.genreLabel.text = "#\(movieList[indexPath.item].movieGenre)"
        cell.genreLabel.font = .boldSystemFont(ofSize: 16)
        let urlPlus = "\(EndPoint.profileURL)\(movieList[indexPath.item].moviePoster)"
        guard let url = URL(string: urlPlus) else { return UICollectionViewCell() }
        cell.posterView.kf.setImage(with: url)
        
        cell.rateTextLabel.text = "평점"
        
        cell.rateValueLabel.text = String(format: "%.1f", movieList[indexPath.item].movieVoteAverage)
        
        cell.movieNameLabel.text = movieList[indexPath.item].movieName
        cell.clipButton.setImage(UIImage(named: "clip.png"), for: .normal)
        cell.clipButton.setTitle("", for: .normal)
        

        
       
        if indexPath.item <= castAll.count - 1{
               var index = 0
               for castName in 0..<castAll[indexPath.item].count {
                   if index == 0 {
                       cell.movieCredtisLabel.text = castAll[indexPath.item][castName].castName
                   } else {
                       cell.movieCredtisLabel.text! += ", \(castAll[indexPath.item][castName].castName)"
                   }
                   index += 1
               }
        }
        
        
        cell.showDetailLabel.text = "Details"
        cell.showdetailImageView.image = UIImage(systemName: "chevron.right")
        
 
        cell.clipButton.addTarget(self, action: #selector(clipButtonTapped), for: .touchUpInside)
        cell.clipButton.tag = indexPath.row
        
        return cell
    }
    
    @objc func clipButtonTapped(sender: UIButton){
        
//        let MediaStoryBoard = UIStoryboard(name: "Media", bundle: nil)
//        guard let webMediaViewController = MediaStoryBoard.instantiateViewController(withIdentifier:  WebMediaViewController.identifier) as? WebMediaViewController else {
//            return
//        }
//        _ = handler?(self.youtubeString ?? "\(EndPoint.youtube2)\(youtubeAll[sender.tag][0].youtubeURL)")
        WebMediaViewController.youtubeNum = sender.tag
        WebMediaViewController.youtubeAll = youtubeAll
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationItem.backButtonTitle = ""
        transitionViewController(storyboard: "Media", ViewController: WebMediaViewController(), transitionStyle: .push)
       
     
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = indexPath.item
        
        
        print(index)
        let trendDetailStoryBoard = UIStoryboard(name: "TrendDetail", bundle: nil)
        guard let trendDetailViewController = trendDetailStoryBoard.instantiateViewController(withIdentifier:  TrendDetailViewController.identifier) as? TrendDetailViewController else {
            return
        }

        let navigationController = UINavigationController(rootViewController: trendDetailViewController)
        navigationController.modalPresentationStyle = .fullScreen
        trendDetailViewController.movieDetail = movieList
        trendDetailViewController.castDetail = castAll
        trendDetailViewController.creditDetail = crewAll
        trendDetailViewController.movieNum = index
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.pushViewController(trendDetailViewController, animated: true)
        self.navigationItem.backButtonTitle = ""


    }
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if movieList.count - 1 == indexPath.item && movieList.count < totalPage{

                startPage += 1

                getMedia()
            }
        }
        print("===pagination===")
    }
    

    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        print("===cancel===")
    }
 
}



extension TrendViewController: UISearchBarDelegate{
    
}
