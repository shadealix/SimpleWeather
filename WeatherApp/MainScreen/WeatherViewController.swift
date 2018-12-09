//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by itstudiodev on 12/5/18.
//  Copyright © 2018 alexey bezrodniy. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, WeatherViewProtocol {
    
    //MARK: IBOutlets
    
    @IBOutlet weak var collectionView:UICollectionView!
    @IBOutlet weak var spinner:UIActivityIndicatorView!
    @IBOutlet weak var searchBar:UISearchBar!
    
    
    //MARK: vars
    
    var presenter:WeatherPresenterProtocol!
    var configurator:WeatherConfigurator = .init()
    var items:[Item] = [Item]() {
        didSet {
            UIView.animate(withDuration: 1, animations: {
                self.collectionView.isHidden = false
                self.searchBar.resignFirstResponder()
            }, completion: { (_) in
                self.collectionView.reloadData()
            })
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
    }
    
    //MARK: View protocol methods
    
    func configureView() {
        searchBar.delegate = self
        collectionView.registerNib()
    }
    
    func update(items:[Item], cityName:String) {
        self.items = items
        self.searchBar.text = cityName
    }
    
    func showAlert(message:String) {
        let alert = UIAlertController(title: "Oops! Something gone wrong!", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func animateSpinner(show:Bool) {
        if show {
            self.spinner.startAnimating()
        } else {
            self.spinner.stopAnimating()
        }
    }
    
    //MARK: IBActions
    
    @IBAction func getWeatherByLocation() {
       presenter.requestWeatherByLocation()
    }
}

//MARK: Delegates

extension WeatherViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(ItemCollectionViewCell.self, for: indexPath)
        cell.setup(items[indexPath.row])
        return cell
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let height:CGFloat = 70.0
        var width:CGFloat = 0.0
        if UIDevice.current.orientation == .portrait {
            width = (screenWidth )  - 20.0
        } else {
            width = (screenWidth / 4) - 20.0
        }
        
        return CGSize(width: width, height: height)
    }
    
     public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5.0
    }
    
     public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5.0
    }
}

extension WeatherViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let city = searchBar.text else {
            return
        }
        presenter.requestWeather(city: city)
    }
}
