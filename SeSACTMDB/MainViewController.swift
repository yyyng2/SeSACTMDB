//
//  MainViewController.swift
//  SeSACTMDB
//
//  Created by Y on 2022/08/03.
//

import UIKit

import Alamofire
import Kingfisher
import SwiftyJSON



class MainViewController: UIViewController {
    
    @IBOutlet weak var mainTableView: UITableView!
    
    let startPage = 1
    var movies: [Movie] = []
    var similars: [[Similar]] = []
    var similar: [Similar] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTableView.dataSource = self
        mainTableView.delegate = self
        
//        TrendAPIManager.shared.getMedia(startPage: startPage) { json in
//
//            print(json)
//
//            for data in json["results"].arrayValue{
//
//                let name = data["original_title"].stringValue
//                let id = data["id"].intValue
//                let release = data["release_date"].stringValue
//                let vote = data["vote_average"].doubleValue
//                let poster = data["poster_path"].stringValue
//                let overView = data["overview"].stringValue
//                let backPoster = data["backdrop_path"].stringValue
//                let genreNum = data["genre_ids"][0].intValue
//
//                guard let rawValue = Genre(rawValue: genreNum) else { return }
//                let genre = "\(rawValue)"
//
//                self.movies.append(Movie(movieName: name, movieID: id, movieRelease: release, moviePoster: poster, movieVoteAverage: vote, movieGenre: genre, movieBackground: backPoster, overView: overView))
//
//
//            }
//
//            self.mainTableView.reloadData()
//        }
//
//        getMedia()
//        self.mainTableView.reloadData()
//        print(self.movies.count, "asdfasdf")
        
        getMedia()
       
        
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

                self.movies.append(Movie(movieName: name, movieID: id, movieRelease: release, moviePoster: poster, movieVoteAverage: vote, movieGenre: genre, movieBackground: backPoster, overView: overView))
               
            }
            self.getRecommendationsURL()
           
        }
    }
    
    func getRecommendationsURL(){
        for i in 0...(movies.count - 1){
           
            let url = "\(EndPoint.similar)\(movies[i].movieID)/similar?api_key=\(APIKey.TMDBKEY)&language=en-US&page=1"
            AF.request(url, method: .get).validate(statusCode: 200..<300).responseData { response in
                switch response.result{
                case .success(let value):
                    let json = JSON(value)
                    self.similar.removeAll()
                    for data in json["results"].arrayValue{
                   
                        let value = data["poster_path"].stringValue
                    
                        self.similar.append(Similar(poster: value))
                    }
                case .failure(let error):
                    print(error)

                }
                self.similars.append(self.similar)
                self.mainTableView.reloadData()
            }
          
            
        }
     
    }
   
  

}

extension MainViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.reuseIdentifier, for: indexPath) as? MainTableViewCell else { return UITableViewCell() }
        cell.contentCollectionView.register(UINib(nibName: "CardCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: CardCollectionViewCell.reuseIdentifier)
        cell.contentCollectionView.delegate = self
        cell.contentCollectionView.dataSource = self
        cell.contentCollectionView.reloadData()
        cell.contentCollectionView.tag = indexPath.row
        cell.titleLabel.text = "\(movies[indexPath.row].movieName)와(과) 비슷한 영화"
        cell.titleLabel.textColor = .white
        cell.backgroundColor = .black
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag <= similars.count {
            return similars.count
        }
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCollectionViewCell.reuseIdentifier, for: indexPath) as? CardCollectionViewCell else { return UICollectionViewCell() }

        if collectionView.tag <= similars.count - 1{
            let urlPlus = "\(EndPoint.profileURL)\(similars[collectionView.tag][indexPath.item].poster)"
            guard let url = URL(string: urlPlus) else { return UICollectionViewCell() }
            cell.cardView.posterImageView.kf.setImage(with: url)
            cell.cardView.posterImageView.contentMode = .scaleAspectFill
        }
//        print("collectionView")
//
//        print("\(movies.count)", "asdfasdfasdf")
        cell.cardView.posterImageView.backgroundColor = .white

        return cell
    }
    
    func collectionViewLayout() -> UICollectionViewFlowLayout{
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 50)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return layout
    }
    
}
