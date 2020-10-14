//
//  ViewController.swift
//  GH Stargazers
//
//  Created by Emanuel Carnevale on 11/10/2020.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var loaderView: UIActivityIndicatorView!
    @IBOutlet var paginationLoaderView: UIActivityIndicatorView!
    static let stargazerCellId = "__stargazer_cell_identifier__"
    
    private let stargazerViewModel = StargazerViewModel()
    private let refreshControl = UIRefreshControl()
    
    private var repo = "octocat/hello-world"

    override func viewDidLoad() {
        super.viewDidLoad()
        stargazerViewModel.delegate = self
        
        tableView.dataSource = self
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshList), for: .valueChanged)
        
        loadingData(for: repo)
        loadingMoreElements(false)
    }

    @objc func refreshList() {
        stargazerViewModel.fetchStargazers(for: "Alamofire/Alamofire")
    }
    
    private func loadingData(for searchString: String) {
        loaderView.isHidden = false
        tableView.isHidden = true
        loaderView.startAnimating()
        stargazerViewModel.fetchStargazers(for: searchString)
    }
    
    private func stopLoading() {
        loaderView.isHidden = true
        tableView.isHidden = false
        loaderView.stopAnimating()
    }
    
    private func loadingMoreElements(_ isLoading: Bool) {
        tableView.tableFooterView?.isHidden = !isLoading
        paginationLoaderView.startAnimating()
    }
}

extension ViewController: StargazerViewModelDelegate {
    func onCompletion(stargazers: [Stargazer]) {
        stopLoading()
        tableView.reloadData()
        
        if refreshControl.isRefreshing {
            refreshControl.endRefreshing()
        }
    }
    
    func onError(errorMessage: String) {
        //TODO

    }
    
    func isLoadingMore(_ bool: Bool) {
        loadingMoreElements(bool)
    }
}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stargazerViewModel.stargazers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ViewController.stargazerCellId, for: indexPath) as! StargazerTableViewCell
        cell.setup(with: stargazerViewModel.stargazers[indexPath.row])
        
        if (indexPath.row == stargazerViewModel.stargazers.count - 1) {
            stargazerViewModel.fetchStargazers(for: repo)
        }
        return cell
    }
}
