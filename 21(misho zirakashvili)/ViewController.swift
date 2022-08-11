//
//  ViewController.swift
//  21(misho zirakashvili)
//
//  Created by misho zirakashvili on 11.08.22.
//

import UIKit

class ViewController: UIViewController {
    
    var countryList: [Country] = [Country]()
    var filteredData = [Country]()
    
    private let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView.init(style: UIActivityIndicatorView.Style.medium)
    
    private let search: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        searchBar.frame = CGRect(x: Constants.searchAndTableViewX,y: Constants.searchY,width: Constants.searchAndTableViewWidth,height: Constants.searchHeight)
        return searchBar
    }()
    
    
    private let tableView:UITableView = {
        let tableView = UITableView()
        tableView.frame = CGRect(x: Constants.searchAndTableViewX,y: Constants.tableViewY,width: Constants.searchAndTableViewWidth,height: Constants.tableViewHeight)
        return tableView
    }()
    private struct Constants {
        static let searchAndTableViewX: CGFloat = 0
        static let searchY: CGFloat = 180
        static let searchAndTableViewWidth: CGFloat = UIScreen.main.bounds.width
        static let searchHeight: CGFloat = 50
        static let tableViewY: CGFloat = 250
        static let tableViewHeight: CGFloat = UIScreen.main.bounds.height - 150
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigationControllerAndViewSubviews()
        fetchCountry()
        tableViewAndSearchbarDelegateConform()
    }
    private func tableViewAndSearchbarDelegateConform() {
        search.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func configNavigationControllerAndViewSubviews() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Countries list"
        view.backgroundColor = .systemGray4
        view.addSubview(search)
        view.addSubview(tableView)
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        activityIndicator.center = self.view.center
    }
    
    private func fetchCountry() {
        FetchCountries.shared.fetchCountry { result in
            switch result {
            case .success(let countries):
                self.countryList = countries
                self.filteredData = self.countryList
                self.tableView.reloadData()
                self.activityIndicator.removeFromSuperview()
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = filteredData[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailsViewController()
        vc.data = filteredData[indexPath.row]
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredData = searchText.isEmpty ? countryList : countryList.filter({(dataString: Country) -> Bool in
            return dataString.name.range(of: searchText, options: .caseInsensitive) != nil
        })
        
        tableView.reloadData()
    }
}

