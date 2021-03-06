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
    
    private let session: Session!
    
    private let genericErrorMessage = "Errore!"
    private let emptyArrayMessage = "Non sono stati trovati stargazers"
    var stargazers: [Stargazer] = []
    
    static let elementsPerPage = 10
    private var currentPage = 1
    private var isFetchInProgress = false
    
    init(configuration: URLSessionConfiguration = URLSessionConfiguration.af.default) {
        self.session = Session(configuration: configuration)
    }
    
    func fetchStargazers(for repository: String) {
        guard !isFetchInProgress else {
            return
        }
        
        if currentPage > 1 {
            self.delegate?.isLoadingMore(true)
        }
        
        let headers: HTTPHeaders = ["Accept": "application/vnd.github.v3+json"]
        let requestURL = "https://api.github.com/repos/\(repository)/stargazers?per_page=\(StargazerViewModel.elementsPerPage)&page=\(currentPage)"
        
        session.request(requestURL, headers: headers).responseJSON { [self] response in
            
            switch(response.result) {
            case .success:
                let decoder = JSONDecoder()
                if let data = response.data {
                    do {
                        let stargazers = try decoder.decode([Stargazer].self, from: data)
                        
                        self.isFetchInProgress = false
                        self.stargazers.append(contentsOf: stargazers)
                        self.currentPage += 1
                        
                        if stargazers.isEmpty {
                            if currentPage > 2 {
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
