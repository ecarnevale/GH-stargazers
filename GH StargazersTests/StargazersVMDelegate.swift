//
//  StargazersVMDelegate.swift
//  GH StargazersTests
//
//  Created by Emanuel Carnevale on 15/10/2020.
//

import Foundation
import XCTest

class StargazersVMDelegate: StargazerViewModelDelegate {
    
    var expectation: XCTestExpectation
    var onCompletionBlock: () -> Void
    var onErrorBlock: (String) -> Void
    var isLoadingMoreBlock: (Bool) -> Void
    
    init(viewModel: StargazerViewModel, expectation: XCTestExpectation, onCompletionBlock: @escaping  () -> Void, onErrorBlock: @escaping (String) -> Void, isLoadingMoreBlock: @escaping (Bool) -> Void ) {
        
        self.expectation = expectation
        self.onCompletionBlock = onCompletionBlock
        self.onErrorBlock = onErrorBlock
        self.isLoadingMoreBlock = isLoadingMoreBlock
    }
    
    var asyncExpectation: XCTestExpectation?
    
    func onCompletion() {
        onCompletionBlock()
        expectation.fulfill()
    }
    
    func onError(errorMessage: String) {
        onErrorBlock(errorMessage)
        expectation.fulfill()
    }
    
    func isLoadingMore(_ bool: Bool) {
        isLoadingMoreBlock(bool)
        expectation.fulfill()
    }
}
