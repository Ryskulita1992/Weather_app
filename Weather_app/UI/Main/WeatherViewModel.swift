//
//  MainViewModel.swift
//  Weather_app
//
//  Created by admin on 04.08.2021.
//

import Foundation
protocol WeatherDelegate: class {
    func loadWeatherSucces(model: WeatherModel)
    func setDate(dateFormatter :DateFormatter, date: Date)
    func showError(err: String)
}
class WeatherViewModel {
    private weak var delegate: WeatherDelegate? = nil
    
    private lazy var repo: AuthClient = {
    return AuthClient()
    }()
    
    var dailyWeather : [Daily] = []
  
    init(delegate: WeatherDelegate) {
        self.delegate = delegate
    }
    

    func loadWeatherInfo(lat:Double, lon: Double){
        repo.getWeather(lat: lat, lon: lon) { (result) in
            switch result {
            case .success(let response):
                let date = Date()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat =  "EEEE"
                self.delegate?.setDate(dateFormatter: dateFormatter, date: date)
                self.delegate?.loadWeatherSucces(model: response)
                
                self.dailyWeather.append(contentsOf: response.daily)
                print("daile\(response.daily)")
                
            
            case .failure(let error):
                self.delegate?.showError(err: error.localizedDescription)
                
            }
            
        }
    }
    
    
}
