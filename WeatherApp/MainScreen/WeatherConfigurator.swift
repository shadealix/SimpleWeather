//
//  WeatherConfigurator.swift
//  WeatherApp
//
//  Created by itstudiodev on 12/9/18.
//  Copyright © 2018 alexey bezrodniy. All rights reserved.
//

import Foundation

class WeatherConfigurator: WeatherConfiguratorProtocol {
    
    func configure(with viewController: WeatherViewController) {
        viewController.configureView()
        let presenter = WeatherPresenter(view: viewController)
        let interactor = WeatherInteractor(presenter: presenter)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
    }
}
