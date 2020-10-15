//
//  StargazersViewController.swift
//  GH Stargazers
//
//  Created by Emanuel Carnevale on 11/10/2020.
//

import UIKit

class StargazersViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var loaderView: UIActivityIndicatorView!
    @IBOutlet var paginationLoaderView: UIActivityIndicatorView!
    static let stargazerCellId = "__stargazer_cell_identifier__"
    
    private let stargazerViewModel = StargazerViewModel()
    
    var repository = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = repository
        stargazerViewModel.delegate = self
        
        tableView.dataSource = self
        
        loadingData(for: repository)
        loadingMoreElements(false)
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

extension StargazersViewController: StargazerViewModelDelegate {
    func onCompletion() {
        stopLoading()
        tableView.reloadData()
    }
    
    func onError(errorMessage: String) {
        stopLoading()
        let action = UIAlertAction(title: "Ok", style: .default, handler: { _ in
            self.dismiss(animated: true, completion: nil)
            self.navigationController?.popViewController(animated: true)
        })
        let alertController = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func isLoadingMore(_ bool: Bool) {
        loadingMoreElements(bool)
    }
}

extension StargazersViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stargazerViewModel.stargazers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StargazersViewController.stargazerCellId, for: indexPath) as! StargazerTableViewCell
        cell.setup(with: stargazerViewModel.stargazers[indexPath.row])
        
        if (indexPath.row == stargazerViewModel.stargazers.count - 1) {
            stargazerViewModel.fetchStargazers(for: repository)
        }
        return cell
    }
}
