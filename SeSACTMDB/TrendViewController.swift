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

    @IBOutlet weak var trendSearchBar: UISearchBar!
    @IBOutlet weak var trendCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        trendSearchBar.delegate = self
        trendCollectionView.delegate = self
        trendCollectionView.dataSource = self
        
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
        getMedia()

    }

    var movieList: [Movie] = []
    var crewList: [Credits] = []
    var castList: [Casts] = []
    
    
    func getMedia(){
        let url = "\(EndPoint.tmdbURL)api_key=\(APIKey.TMDBKEY)"
        
        AF.request(url, method: .get).validate(statusCode: 200..<300).responseData { response in
            switch response.result{
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                for data in json["results"].arrayValue{

                    let name = data["original_title"].stringValue
                    let id = data["id"].intValue
                    let release = data["release_date"].stringValue
                    let vote = data["vote_average"].doubleValue
                    let poster = data["poster_path"].stringValue
                    let overView = data["overview"].stringValue
                    let backPoster = data["backdrop_path"].stringValue
                    let genreNum = data["genre_ids"][0].intValue
                    //print("장르숫자\(data["genre_ids"][0].intValue)")
                    guard let rawValue = Genre(rawValue: genreNum) else { return }
                    let genre = "\(rawValue)"
                    //print("장르글자\(genre)")
                    self.movieList.append(Movie(movieName: name, movieID: id, movieRelease: release, moviePoster: poster, movieVoteAverage: vote, movieGenre: genre, movieBackground: backPoster, overView: overView))
                    
                }
                //print(self.movieList[0].movieID)
                self.getCasts()
            case .failure(let error):
                print(error)
                
            }
        }
    }
    

    
    
    
    func getCasts(){
        for i in 0...(movieList.count - 1){

            let url = "\(EndPoint.castsURL)\(movieList[i].movieID)/credits?api_key=\(APIKey.TMDBKEY)"

            AF.request(url, method: .get).validate(statusCode: 200..<300).responseData { response in
                switch response.result{
                case .success(let value):
                    let json = JSON(value)
                    //print("JSON: \(json)")
                    
                    for data in json["cast"].arrayValue{
                        let castName = data["name"].stringValue
                        let castProfile = data["profile_path"].stringValue
                        let char = data["character"].stringValue
                        
                        self.castList.append(Casts(castName: castName, character: char, profile: castProfile))
                        
                    }
                    
                    for data in json["crew"].arrayValue{

                        let crewName = data["name"].stringValue
                        let crewProfile = data["profile_path"].stringValue
                        let job = data["job"].stringValue
   
                        self.crewList.append(Credits(crewName: crewName, job: job, profile: crewProfile))
                   
                        
                    }
                    self.trendCollectionView.reloadData()
                    //print("\(self.crewList)크루\(self.castList)")

                case .failure(let error):
                    print(error)

                }
            }

        }

    }
    
    
    
    
  
}


extension TrendViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDataSourcePrefetching{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList.count
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrendCollectionViewCell.identifier, for: indexPath) as? TrendCollectionViewCell else { return UICollectionViewCell() }
        cell.posterView.layer.cornerRadius = 10
        cell.posterView.posterImageView.layer.cornerRadius = 10
        cell.posterView.posterImageView.clipsToBounds = true
        cell.posterView.posterImageView.backgroundColor = .clear
        cell.posterView.layer.masksToBounds = false
        cell.backgroundColor = .clear
        cell.posterView.layer.cornerRadius = 10
        cell.posterView.layer.masksToBounds = false
        cell.posterView.layer.shadowOpacity = 0.8
        cell.posterView.layer.shadowOffset = CGSize(width: 2, height: 2)
        cell.posterView.layer.shadowRadius = 5
        cell.infoView.layer.cornerRadius = 10
        cell.infoView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        cell.rateTextLabel.layer.cornerRadius = 5
        cell.rateTextLabel.clipsToBounds = true
        cell.rateTextLabel.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        cell.rateValueLabel.layer.cornerRadius = 5
        cell.rateValueLabel.clipsToBounds = true
        cell.rateValueLabel.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        cell.releaseLabel.text = movieList[indexPath.row].movieRelease
        cell.releaseLabel.font = .systemFont(ofSize: 13)
        cell.releaseLabel.textColor = .systemGray
        cell.genreLabel.text = "#\(movieList[indexPath.row].movieGenre)"
        cell.genreLabel.font = .boldSystemFont(ofSize: 16)
        let urlPlus = "https://www.themoviedb.org/t/p/w1280/\(movieList[indexPath.row].moviePoster)"
        guard let url = URL(string: urlPlus) else { return UICollectionViewCell() }
        cell.posterView.posterImageView.kf.setImage(with: url)
        cell.posterView.posterImageView.contentMode = .scaleAspectFill
        cell.infoView.backgroundColor = .white
        cell.rateTextLabel.text = "평점"
        cell.rateTextLabel.textAlignment = .center
        cell.rateTextLabel.textColor = .white
        cell.rateTextLabel.backgroundColor = .black
        cell.rateValueLabel.text = String(format: "%.1f", movieList[indexPath.row].movieVoteAverage)
        cell.rateValueLabel.textAlignment = .center
        cell.rateValueLabel.backgroundColor = .white
        cell.movieNameLabel.text = movieList[indexPath.row].movieName
        cell.movieCredtisLabel.text = "\(castList[0].castName), \(castList[1].castName), \(castList[2].castName)"
        cell.movieCredtisLabel.textColor = .systemGray
        cell.showDetailButton.setTitle("Details       ", for: .normal)
        cell.showDetailButton.backgroundColor = .clear
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = indexPath.item
        UserDefaults.standard.set(index, forKey: "index")
        
        print(index)
        let trendDetailStoryBoard = UIStoryboard(name: "TrendDetail", bundle: nil)
        guard let trendDetailViewController = trendDetailStoryBoard.instantiateViewController(withIdentifier:  TrendDetailViewController.identifier) as? TrendDetailViewController else {
            return
        }
        let navigationController = UINavigationController(rootViewController: trendDetailViewController)
        navigationController.modalPresentationStyle = .fullScreen
        trendDetailViewController.movieDetail = movieList
        self.navigationController?.pushViewController(trendDetailViewController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        print("===pagination===")
    }
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        print("===cancel===")
    }
 
}

extension TrendViewController: UISearchBarDelegate{
    
}
