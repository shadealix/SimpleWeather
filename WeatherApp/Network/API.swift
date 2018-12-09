//
//  API.swift
//  WeatherApp
//
//  Created by itstudiodev on 12/6/18.
//  Copyright © 2018 alexey bezrodniy. All rights reserved.
//

import Foundation

enum Method: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

class APIClient {
    private let baseURL = "https://api.openweathermap.org/"
    fileprivate let forecast = "/data/2.5/forecast"
    fileprivate let APIKey = "ec82f1346b381a7e0ea0807457e65e4d"
    fileprivate var baseParams:[String: String] {
        return ["units": "metric", "appid": APIKey]
    }
    
    static let shared:APIClient = .init()
    private init() {}
    
    func requestWeather(_ city:String,  completion: @escaping (APIResponse?, URLResponse?, Error?)->())  {
        var params = baseParams
        params["q"] = city
        guard let request = URLRequest.createRequest(baseUrl: baseURL, endPoint: forecast, params: params) else {
            completion(nil, nil, NSError(domain:"bad request", code:0, userInfo:nil))
            return
        }
    
        perform(responseType: APIResponse.self, request: request) { (apiResponse, response, error) in
            completion(apiResponse, response, error)
        }
    }
    
    func requestWeather(lat:Double, lon:Double, completion: @escaping (APIResponse?, URLResponse?, Error?)->())  {
        var params = baseParams
        params["lat"] = "\(lat)"
        params["lon"] = "\(lon)"
        
        guard let request = URLRequest.createRequest(baseUrl: baseURL, endPoint: forecast, params: params) else {
            completion(nil, nil, NSError(domain:"bad request", code:0, userInfo:nil))
            return
        }
        
        perform(responseType: APIResponse.self, request: request) { (apiResponse, response, error) in
            completion(apiResponse, response, error)
        }
    }
    
    private func perform<D:Decodable>(responseType:D.Type, request:URLRequest, session:URLSession = .shared, completion: @escaping (D?, URLResponse?, Error?)->()) {
        session.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let apiResponse = try JSONDecoder().decode(D.self, from: data)
                    completion(apiResponse, response, error)
                } catch {
                    completion(nil, response, error)
                }
            } else {
                completion(nil, response, error)
            }
        }.resume()
    }
}
