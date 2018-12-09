//
//  LocationManager.swift
//  WeatherApp
//
//  Created by itstudiodev on 12/7/18.
//  Copyright © 2018 alexey bezrodniy. All rights reserved.
//

import Foundation
import CoreLocation

class LocationManager:NSObject {

    static let shared:LocationManager = LocationManager()
    fileprivate var completion:((CLLocation?, Error?)->())?
    fileprivate let manager = CLLocationManager()
    
    private override init() {}
    
    func getLocation(completion: @escaping (CLLocation?, Error?)->()) {
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.requestLocation()
        self.completion = completion
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let completion = self.completion {
            completion(locations.first, nil)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if let completion = self.completion {
            completion(nil, error)
        }
    }
}
