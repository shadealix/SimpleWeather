//
//  WeatherInteractor.swift
//  WeatherApp
//
//  Created by itstudiodev on 12/9/18.
//  Copyright © 2018 alexey bezrodniy. All rights reserved.
//

import Foundation

class WeatherInteractor: WeatherInteractorProtocol {
    
    weak var presenter: WeatherPresenterProtocol!
    private lazy var networkService: APIClient = .shared
    private lazy var locationService: LocationManager = .shared
    
    required init(presenter: WeatherPresenterProtocol) {
        self.presenter = presenter
    }
    
    func requestWeather(city: String) {
        networkService.requestWeather(city) { (apiResponse, response, error) in
            self.presenter.updateView(apiResponse: apiResponse, urlResponse: response, error: error)
        }
    }
    
    func requestWeatherByLocation() {
        locationService.getLocation { (location, error) in
            if let location = location {
                self.networkService.requestWeather(lat: location.coordinate.latitude, lon: location.coordinate.longitude, completion: { (apiResponse, urlResponse, error) in
                    self.presenter.updateView(apiResponse: apiResponse, urlResponse: urlResponse, error: error)
                })
            }
            if let error = error {
                self.presenter.updateView(apiResponse: nil, urlResponse: nil, error: error)
            }
        }
    }
}
