//
//  StargazerViewModel.swift
//  GH Stargazers
//
//  Created by Emanuel Carnevale on 11/10/2020.
//

import Foundation
import Alamofire

protocol StargazerViewModelDelegate: class {
    func onCompletion()
    func onError(errorMessage: String)
    func isLoadingMore(_ bool: Bool)
}

final class StargazerViewModel {
    weak var delegate: StargazerViewModelDelegate?
    
    private let genericErrorMessage = "Errore!"
    private let emptyArrayMessage = "Errore vuoto"
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
                if let data = response.data {
                    do {
                        let stargazers = try decoder.decode([Stargazer].self, from: data)
                        
                        self.currentPage += 1
                        self.isFetchInProgress = false
                        self.stargazers.append(contentsOf: stargazers)
                    
                        if stargazers.isEmpty {
                            if currentPage > 1 {
                                self.delegate?.isLoadingMore(false)
                            } else {
                                delegate?.onError(errorMessage: emptyArrayMessage)
                            }
                        } else {
                            delegate?.onCompletion()
                        }
                    }
                    catch {
                        let error = try? decoder.decode(RequestError.self, from: data)
                        delegate?.onError(errorMessage: error?.message ?? genericErrorMessage)
                    }
                }
            case .failure:
                delegate?.onError(errorMessage: response.error?.errorDescription ?? genericErrorMessage)
            }
            
        }
        
    }
}
