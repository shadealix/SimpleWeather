//
//  WeatherProtocols.swift
//  WeatherApp
//
//  Created by itstudiodev on 12/9/18.
//  Copyright © 2018 alexey bezrodniy. All rights reserved.
//

import Foundation

protocol WeatherViewProtocol: class {
    func update(items:[Item], cityName:String)
    func showAlert(message:String)
    func animateSpinner(show:Bool)
    func configureView()
}

protocol WeatherPresenterProtocol: class {
    func requestWeather(city:String)
    func requestWeatherByLocation()
    func updateView(apiResponse:APIResponse?, urlResponse:URLResponse?, error:Error?)
}

protocol WeatherInteractorProtocol: class {
    func requestWeather(city:String)
    func requestWeatherByLocation()
}

protocol WeatherConfiguratorProtocol: class {
    func configure(with viewController: WeatherViewController)
}
