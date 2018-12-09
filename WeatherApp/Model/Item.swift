//
//  Item.swift
//  WeatherApp
//
//  Created by itstudiodev on 12/5/18.
//  Copyright © 2018 alexey bezrodniy. All rights reserved.
//

import Foundation

struct Item: Codable {
    let dt: Int
    let main: MainClass
    let weather: [Weather]
    
    enum CodingKeys: String, CodingKey {
        case dt, main, weather
    }
    
    var degrees: String {
        return main.temp <= 0 ? "\(main.temp) °C" : "+\(main.temp) °C"
    }
    
    var date: String {
        return DateFormatter(format: "d MMMM HH:mm")
            .string(from: Date(timeIntervalSince1970: TimeInterval(dt)))
    }
    
    var weatherDescription: String {
        guard let descr = weather.first?.description else {
            return ""
        }
        return descr
    }
}

struct MainClass: Codable {
    let temp, tempMin, tempMax: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}

struct Weather: Codable {
    let description: String
}

struct City: Codable {
    let name: String
}

struct APIResponse: Decodable {
    let cod: String
    let list: [Item]?
    let city: City?
}

