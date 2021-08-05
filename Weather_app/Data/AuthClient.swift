//
//  AuthClient.swift
//  Weather_app
//
//  Created by admin on 04.08.2021.
//

import Foundation
import CoreLocation

class AuthClient {
    
    private var dataTask : URLSessionDataTask?
    
    func getWeather(lat: Double, lon: Double, completion: @escaping (Result<WeatherModel , Error>) -> Void) {
        let url = URL(string: "\(Constants.api_url)lat=\(lat.description)&lon=\(lon.description)&exclude=minutes&exclude=hourly&units=metric&appid=\(Constants.weather_key)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error{
                completion(.failure(error))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                return
            }
            debugPrint(response.statusCode)
            guard let data = data else {
                print ("Empty data")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(WeatherModel.self, from: data)
                DispatchQueue.main.sync {
                    completion(.success(jsonData))
                }
                
            } catch let error {
                completion(.failure(error))
            }
        }
        dataTask?.resume()
    }
}
