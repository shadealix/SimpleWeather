//
//  WeatherPresenter.swift
//  WeatherApp
//
//  Created by itstudiodev on 12/9/18.
//  Copyright © 2018 alexey bezrodniy. All rights reserved.
//

import Foundation

class WeatherPresenter: WeatherPresenterProtocol {
    
    weak var view: WeatherViewProtocol!
    var interactor: WeatherInteractorProtocol!
    
    required init(view: WeatherViewProtocol) {
        self.view = view
    }
    
    // MARK: - WeatherPresenterProtocol methods
    
    func requestWeather(city: String) {
        DispatchQueue.main.async {
            self.view.animateSpinner(show: true)
        }
        interactor.requestWeather(city: city)
    }
    
    func requestWeatherByLocation() {
        DispatchQueue.main.async {
            self.view.animateSpinner(show: true)
        }
        interactor.requestWeatherByLocation()
    }
    
    func updateView(apiResponse:APIResponse?, urlResponse:URLResponse?, error:Error?) {
        DispatchQueue.main.async {
            self.view.animateSpinner(show: false)
            if let apiResponse = apiResponse, let items = apiResponse.list {
                self.view.update(items: items, cityName: apiResponse.city?.name ?? "unknown city")
            }
            if let error = error {
                self.view.showAlert(message: error.localizedDescription)
            }
        }
    }
}
