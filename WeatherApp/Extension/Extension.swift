//
//  Extension.swift
//  WeatherApp
//
//  Created by itstudiodev on 12/5/18.
//  Copyright © 2018 alexey bezrodniy. All rights reserved.
//

import UIKit

extension UICollectionView {
    func dequeueReusableCell<T: UICollectionViewCell>(_ withClass: T.Type, for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withReuseIdentifier: String(describing: withClass), for: indexPath) as! T
    }
    
    func registerNib() {
        self.register(UINib(nibName: String(describing: ItemCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: ItemCollectionViewCell.self))
    }
}

extension URL {
    
    func addEndpoint(endpoint: String) -> URL {
        return URL(string: endpoint, relativeTo: self)!
    }
    
    func addParams(params: [String: String]?) -> URL {
        guard let params = params, var urlComp = URLComponents(url: self, resolvingAgainstBaseURL: true) else {
            return self
        }
        var queryItems = [URLQueryItem]()
        for (key, value) in params {
            queryItems.append(URLQueryItem(name: key, value: value))
        }
        urlComp.queryItems = queryItems
        guard let url = urlComp.url else {
            return self
        }
        return url
    }
}

extension DateFormatter {
    convenience init (format: String) {
        self.init()
        dateFormat = format
        locale = Locale.current
    }
}

extension String {
    func toDate(format: String) -> Date? {
        return DateFormatter(format: format).date(from: self)
    }
    
    func toDateString(inputFormat: String, outputFormat:String) -> String? {
        if let date = toDate(format: inputFormat) {
            return DateFormatter(format: outputFormat).string(from: date)
        }
        return nil
    }
}
