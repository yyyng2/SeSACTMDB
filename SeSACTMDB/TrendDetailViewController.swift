//
//  TrendDetailViewController.swift
//  SeSACTMDB
//
//  Created by Y on 2022/08/04.
//

import UIKit

import Alamofire
import Kingfisher
import SwiftyJSON

class TrendDetailViewController: UIViewController {
    
    var movieDetail: [Movie] = []
    var castDetail: [[Casts]] = []
    var creditDetail: [[Credits]] = []
    var movieNum: Int = 0
    var header = ["OverView","Cast","Credit"]
    var isExpanded = false
    
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var trendTableView: UITableView!
    @IBOutlet weak var detailMovieName: UILabel!
    @IBOutlet weak var backImageView: UIImageView!
    static let identifier = "TrendDetailViewController"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        designDetail()
        trendTableView.delegate = self
        trendTableView.dataSource = self
        
        
    }
    
    func designDetail(){
        let urlPlus1 = "\(EndPoint.profileURL)\(movieDetail[movieNum].movieBackground)"
        guard let url1 = URL(string: urlPlus1) else { return }
        backImageView.kf.setImage(with: url1)
        let urlPlus2 = "\(EndPoint.profileURL)\(movieDetail[movieNum].moviePoster)"
        guard let url2 = URL(string: urlPlus2) else { return }
        posterView.kf.setImage(with: url2)
        posterView.contentMode = .scaleAspectFill
        detailMovieName.text = movieDetail[movieNum].movieName
        detailMovieName.textColor = .white
        detailMovieName.font = .boldSystemFont(ofSize: 20)
        title = "Casts/Credits"
        self.navigationItem.backButtonTitle = ""
        self.navigationItem.backBarButtonItem?.tintColor = .black
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        } else if section == 1{
       
            return castDetail.count
        } else if section == 2{

            return creditDetail.count
        } else {
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return header[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0{
            
            guard let cell: OverviewTableViewCell = tableView.dequeueReusableCell(withIdentifier: OverviewTableViewCell.identifier) as? OverviewTableViewCell else { return UITableViewCell() }
            cell.overviewLabel.text = movieDetail[movieNum].overView
            cell.overviewLabel.font = .systemFont(ofSize: 12)
            cell.overviewLabel.numberOfLines = 0
            cell.overviewLabel.numberOfLines = isExpanded ? 0 : 2
            cell.arrowImage.tintColor = .black
            cell.arrowImage.image = UIImage(systemName: "chevron.down")

//            tableView.rowHeight = isExpanded ? UITableView.automaticDimension : 100
           
            return cell
        } else if indexPath.section == 1 {
            
           
            
            guard let cell: CastTableViewCell = tableView.dequeueReusableCell(withIdentifier: CastTableViewCell.identifier, for: indexPath) as? CastTableViewCell else { return UITableViewCell() }
    
            
           
            if castDetail[movieNum][indexPath.row].profile == ""{
                let image = "user.png"
                cell.profileImage.image = UIImage(named: image)
            } else {
                let profile = castDetail[movieNum][indexPath.row].profile

                let urlPlus = "\(EndPoint.profileURL)\(profile)"
                let url = URL(string: urlPlus)
        
                let image = "user.png"
                cell.profileImage.kf.setImage(with: url)
            }
            

            cell.castNameLabel.text = castDetail[movieNum][indexPath.row].castName
            cell.charNameLabel.text = castDetail[movieNum][indexPath.row].character

            return cell
            
        } else if indexPath.section == 2{
          

            guard let cell: CastTableViewCell = tableView.dequeueReusableCell(withIdentifier: CastTableViewCell.identifier, for: indexPath) as? CastTableViewCell else { return UITableViewCell() }

            
            if creditDetail[movieNum][indexPath.row].profile == ""{
                let image = "user.png"
                cell.profileImage.image = UIImage(named: image)
            } else {
//                let profile = creditAll[indexPath.section][indexPath.item].profile
//                let urlPlus = "https://www.themoviedb.org/t/p/w1280\(profile)"
//                let url = URL(string: urlPlus)
//                print("\(url)success")
                let image = "user.png"
//                cell.profileImage.kf.setImage(with: url)
            }
        
//            cell.castNameLabel.text = creditAll[indexPath.section][indexPath.item].crewName
//            cell.charNameLabel.text = creditAll[indexPath.section][indexPath.item].job

            return cell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0{
            isExpanded = !isExpanded
            tableView.reloadData()
            
        }
    }
     

        
//        if indexPath.section == 0 {
//            guard let cell: OverviewTableViewCell = tableView.dequeueReusableCell(withIdentifier: OverviewTableViewCell.identifier) as? OverviewTableViewCell else { return UITableViewCell() }
//            cell.overviewLabel.text = movieDetail[index].overView
//            cell.overviewLabel.font = .systemFont(ofSize: 12)
//            cell.overviewLabel.numberOfLines = 0
//            return cell
//        } else if indexPath.section == 1{
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: CastTableViewCell.identifier) as? CastTableViewCell else { return UITableViewCell() }
//            let index = UserDefaults.standard.integer(forKey: "index")
//            let array = castDetail[index]
//            let urlPlus = "https://www.themoviedb.org/t/p/w1280/\(castDetail[indexPath.row].profile)"
//            guard let url = URL(string: urlPlus) else { return UITableViewCell() }
//            cell.profileImageView.kf.setImage(with: url)
//            cell.nameLabel.text = castDetail[indexPath.row].castName
//            cell.charLabel.text = castDetail[indexPath.row].character
//            print(array)
//            print("제발\(castDetail)")
//            return cell
//        } else if indexPath.section == 2 {
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: CreditTableViewCell.identifier) as? CreditTableViewCell else { return UITableViewCell() }
//            let index = UserDefaults.standard.integer(forKey: "index")
//            let urlPlus = "https://www.themoviedb.org/t/p/w1280/\(creditDetail[index].profile)"
//            guard let url = URL(string: urlPlus) else { return UITableViewCell() }
//            cell..kf.setImage(with: url)
//            cell.nameLabel.text = creditDetail[index].crewName
//            cell.charLabel.text = creditDetail[index].job
       
        

        
  


}
extension TrendDetailViewController: UITableViewDelegate, UITableViewDataSource{

    
}
