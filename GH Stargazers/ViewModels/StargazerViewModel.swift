//
//  StargazerViewModel.swift
//  GH Stargazers
//
//  Created by Emanuel Carnevale on 11/10/2020.
//

import Foundation
import Alamofire

protocol StargazerViewModelDelegate: class {
    func onCompletion(stargazers: [Stargazer])
    func onError(errorMessage: String)
    func isLoadingMore(_ bool: Bool)
}

final class StargazerViewModel {
    weak var delegate: StargazerViewModelDelegate?
    
    private let genericErrorMessage = "Errore!"
    var stargazers: [Stargazer] = []
    
    static let elementsPerPage = 100
    private var currentPage = 1
    private var isFetchInProgress = false
    
    func fetchStargazers(for repository: String) {
        guard !isFetchInProgress else {
            return
        }
        
        if currentPage > 1 {
            self.delegate?.isLoadingMore(true)
        }
        
        AF.request("https://api.github.com/repos/\(repository)/stargazers?per_page=\(StargazerViewModel.elementsPerPage)&page=\(currentPage)").responseJSON { [self] response in
            
            switch(response.result) {
            case .success:
                let decoder = JSONDecoder()
                let stargazers = try? decoder.decode([Stargazer].self, from: response.data!)
                if let stargazers = stargazers {
                    
                    self.currentPage += 1
                    self.isFetchInProgress = false
                    self.stargazers.append(contentsOf: stargazers)
                    delegate?.onCompletion(stargazers: stargazers)
                } else {
                    if currentPage > 1 {
                        self.delegate?.isLoadingMore(false)
                    } else {
                        delegate?.onError(errorMessage: genericErrorMessage)
                    }
                }
            case .failure:
                delegate?.onError(errorMessage: response.error?.errorDescription ?? genericErrorMessage)
            }
            
        }
        
    }
}
