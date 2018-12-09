//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by itstudiodev on 12/9/18.
//  Copyright © 2018 alexey bezrodniy. All rights reserved.
//

import XCTest

class WeatherAppTests: XCTestCase {
    
    var networkClient: APIClient = .shared
    
    func testCityRequest() {
        let expectedCity = "Kyiv"
        networkClient.requestWeather(expectedCity) { (apiResponse, _, _) in
            if let responseCity = apiResponse?.city {
                XCTAssertEqual(responseCity.name, expectedCity)
            }
        }
    }
    
    func testCoordinatesRequest() {
        let latitude = 50.45466
        let lontitude = 30.5238
        let expectedCity = "Kyiv"
        networkClient.requestWeather(lat: latitude, lon: lontitude) { (apiResponse, _, _) in
            if let responseCity = apiResponse?.city {
                XCTAssertEqual(responseCity.name, expectedCity)
            }
        }
    }
    
    func testRequestGeneration() {
        let urlString = "https://mock.url"
        let endpoint = "/test/endpoint"
        let params = ["count":"\(10)", "offset": "\(0)"]
        let request = URLRequest.createRequest(baseUrl: urlString, endPoint: endpoint, params: params)
        let expectedUrl = URL(string: "https://mock.url/test/endpoint?count=10&offset=0")
        XCTAssertEqual(request?.url, expectedUrl!)
        XCTAssertEqual(request?.httpMethod, Method.get.rawValue)
    }
}
