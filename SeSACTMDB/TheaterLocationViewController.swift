//
//  TheaterLocationViewController.swift
//  SeSACTMDB
//
//  Created by Y on 2022/08/11.
//

import UIKit
import CoreLocation
import MapKit

class TheaterLocationViewController: UIViewController {
    
    let center = CLLocationCoordinate2D(latitude: 37.517829, longitude: 126.886270)
    let theaterList = TheaterList()
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        configureNavigationItem()
        setTheaterAnnotation(theater: "All")
        
    }
    
    func configureNavigationItem(){
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Filter", style: .plain, target: self, action: #selector(mapFilter))
    }
    
    @objc func mapFilter(){
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "LotteCinema", style: .default, handler: { UIAlertAction in
            self.setTheaterAnnotation(theater: "LotteCinema")
        }))
        actionSheet.addAction(UIAlertAction(title: "MegaBox", style: .default, handler: { UIAlertAction in
            self.setTheaterAnnotation(theater: "MegaBox")
        }))
        actionSheet.addAction(UIAlertAction(title: "CGV", style: .default, handler: { UIAlertAction in
            self.setTheaterAnnotation(theater: "CGV")
        }))
        actionSheet.addAction(UIAlertAction(title: "All Theater", style: .default, handler: { UIAlertAction in
            self.setTheaterAnnotation(theater: "All")
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        self.present(actionSheet, animated: true)
    }
    
    func setTheaterAnnotation(theater: String){
        
        if theater == "All"{
            self.mapView.removeAnnotations(self.mapView.annotations)
            for i in self.theaterList.mapAnnotations {
                let center = CLLocationCoordinate2D(latitude: i.latitude, longitude: i.longitude)
                           
                let region =  MKCoordinateRegion(center: center, latitudinalMeters: 20000, longitudinalMeters: 20000)
                mapView.setRegion(region, animated: true)
                           
                let annotation = MKPointAnnotation()
                annotation.coordinate = center
                annotation.title = "\(i.location)"
                mapView.addAnnotation(annotation)
            }
        } else {
        self.mapView.removeAnnotations(self.mapView.annotations)
            for i in self.theaterList.mapAnnotations.filter({$0.type == theater}) {

            let center = CLLocationCoordinate2D(latitude: i.latitude, longitude: i.longitude)
                       
            let region =  MKCoordinateRegion(center: center, latitudinalMeters: 20000, longitudinalMeters: 20000)
                self.mapView.setRegion(region, animated: true)
                       
            let annotation = MKPointAnnotation()
            annotation.coordinate = center
            annotation.title = "\(i.location)"
                self.mapView.addAnnotation(annotation)
            }
        }
    }
    
    func setRegionAndAnnotation(center: CLLocationCoordinate2D, title: String){
       
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 20000, longitudinalMeters: 20000)
           mapView.setRegion(region, animated: true)
           
           let annotation = MKPointAnnotation()
           annotation.coordinate = center
           annotation.title = title
           mapView.addAnnotation(annotation)
    }
    
    

}

extension TheaterLocationViewController {
    func checkUserDeviceLocationServiceAuthorization(){
        let authorizationStatus: CLAuthorizationStatus
        if #available(iOS 14.0, *){
            authorizationStatus = locationManager.authorizationStatus
        } else {
            authorizationStatus = CLLocationManager.authorizationStatus()
        }
        
        if CLLocationManager.locationServicesEnabled(){
            checkUserCurrentLocationAuthorization(authorizationStatus)
        }
    }
    
    func checkUserCurrentLocationAuthorization(_ authorizationStatus: CLAuthorizationStatus){
           switch authorizationStatus {
           case .notDetermined:
               locationManager.desiredAccuracy = kCLLocationAccuracyBest
               locationManager.requestWhenInUseAuthorization()
           case .restricted, .denied:
               showRequestLocationServiceAlert()
               setRegionAndAnnotation(center: center, title: "영등포 캠퍼스")
           case .authorizedWhenInUse:
               locationManager.startUpdatingLocation()
           default: print("Default")
           }
    }
       
    func showRequestLocationServiceAlert() {
         let requestLocationServiceAlert = UIAlertController(title: "위치정보 이용", message: "위치 서비스를 사용할 수 없습니다. 기기의 '설정>개인정보 보호'에서 위치 서비스를 켜주세요.", preferredStyle: .alert)
         let goSetting = UIAlertAction(title: "설정으로 이동", style: .destructive) { _ in
             if let appSetting = URL(string: UIApplication.openSettingsURLString){
                 UIApplication.shared.open(appSetting)
             }
         }
         let cancel = UIAlertAction(title: "취소", style: .default)
         requestLocationServiceAlert.addAction(cancel)
         requestLocationServiceAlert.addAction(goSetting)
         
         present(requestLocationServiceAlert, animated: true, completion: nil)
    }
    
}

extension TheaterLocationViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coordinate = locations.last?.coordinate{
            setRegionAndAnnotation(center: coordinate, title: "현재위치")
        }
        
        locationManager.stopUpdatingLocation()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
            print(#function)
            checkUserDeviceLocationServiceAuthorization()
        }
       
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            
        }
}
