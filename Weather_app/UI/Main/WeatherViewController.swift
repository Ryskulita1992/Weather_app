//
//  ViewController.swift
//  Weather_app
//
//  Created by admin on 04.08.2021.
//

import UIKit
import CoreLocation
import Kingfisher

class WeatherViewController: UIViewController {
    let locManager = CLLocationManager()
    var dailyWeather : [Daily] = []

    
    lazy var network: AuthClient = {
        return AuthClient()
    }()
    
    lazy var viewModel: WeatherViewModel = {
        return WeatherViewModel(delegate: self)
    }()
    
    func view() -> Weather_UI_VIEW {
        return self.view as! Weather_UI_VIEW
    }
    
    override func loadView() {
        self.view = Weather_UI_VIEW()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        self.title = "weather app"
        getLocManager()
        view().collectionView.dataSource = self
        view().collectionView.delegate = self
    
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        locManager.stopUpdatingLocation()
    }
    
    func getLocManager(){
        locManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locManager.delegate = self
            locManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            locManager.pausesLocationUpdatesAutomatically = false
            locManager.startUpdatingLocation()
            
        } else {
            
        }
        
    }
}

//MARK: -  VIEW MODEL DELEGATES

extension WeatherViewController : WeatherDelegate {
    func setDate(dateFormatter: DateFormatter, date: Date) {
        view().day_txt.text = dateFormatter.string(from: date)
        print("date\(date)")
        
    }
    
    func loadWeatherSucces(model: WeatherModel) {
        DispatchQueue.main.async {
            self.view().collectionView.reloadData()
        }
        
        view().condition.text = model.current.weather[0].weatherDescription
        if let urlString = (model.current.weather[0].icon ) {
            let urlImage = URL(string: "\(Constants.url_for_image)" + urlString)
            view().image.kf.setImage(with: urlImage)
            
        }
        view().city.text = "\(model.timezone.description)"
        view().temp.text = "\(model.current.temp.description + "°")"
        
        
    }
    
    func showError(err: String) {
        //i should add some alert dialog
    }
    
    
}



//MARK: -   DELEGATES

extension WeatherViewController : CLLocationManagerDelegate, UICollectionViewDelegate,  UICollectionViewDelegateFlowLayout, UICollectionViewDataSource  {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("count\(viewModel.dailyWeather.count)")
        return viewModel.dailyWeather.count
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
      {
        return CGSize(width: 80.0, height: 140.0)
      }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomMainCell", for: indexPath as IndexPath)
            as! WeatherCell
        
        cell.data = viewModel.dailyWeather [indexPath.row]
        print("col view\(cell.data = viewModel.dailyWeather[indexPath.row])")

        cell.layer.backgroundColor = UIColor.white.cgColor
        cell.layer.cornerRadius = 25
        return cell
        
        
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lastLoc = locations.last {
            self.viewModel.loadWeatherInfo(lat: lastLoc.coordinate.latitude, lon: lastLoc.coordinate.longitude )
        }
        
    }
    
}
