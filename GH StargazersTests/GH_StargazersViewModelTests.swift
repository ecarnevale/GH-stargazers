//
//  GH_StargazersViewModelTests.swift
//  GH StargazersTests
//
//  Created by Emanuel Carnevale on 14/10/2020.
//

import XCTest
import Mocker
import Alamofire

class GH_StargazersViewModelTests: XCTestCase {
    
    let configuration = URLSessionConfiguration.af.default
    var viewModel: StargazerViewModel?

    override func setUp() {
        super.setUp()
        configuration.protocolClasses = [MockingURLProtocol.self]
        viewModel = StargazerViewModel(configuration: configuration)
    }

    override func tearDown()  {
        viewModel = nil
        super.tearDown()
    }

    func testRepoNotFound() throws {
        
        let expectation = self.expectation(description: "Request should return error with Not Found message")
        let originalURL = URL(string: "https://api.github.com/repos/octocat/hello-wo/stargazers")!
        
        Mock(url: originalURL, ignoreQuery: true, dataType: .json, statusCode: 200, data: [
            .get: MockedData.notFoundRepo.data
        ]).register()
        
        guard let vm = viewModel else {
            XCTFail("ViewModel not correctly initialized")
            return
        }
        
        let delegate = StargazersVMDelegate(viewModel: vm,
                                            expectation: expectation,
                                            onCompletionBlock: {
                                                XCTFail("Request should not call onCompletion")
                                            },
                                            onErrorBlock: { errorMessage in
                                                XCTAssertEqual(vm.stargazers.isEmpty, true)
                                                XCTAssertEqual(errorMessage, "Not Found" )
                                            },
                                            isLoadingMoreBlock: { isLoading in
                                                XCTFail("Request should not call isLoadingMoreBlock")
                                            })
        
        vm.delegate = delegate
        
        vm.fetchStargazers(for: "octocat/hello-wo")
        waitForExpectations(timeout: 1)
    }

    func testEmptyData() throws {
        
        let expectation = self.expectation(description: "Request should succeed returning empty Array")
        let originalURL = URL(string: "https://api.github.com/repos/octocat/hello-world/stargazers")!
        
        Mock(url: originalURL, ignoreQuery: true, dataType: .json, statusCode: 200, data: [
            .get: MockedData.emptyData.data
        ]).register()
        
        guard let vm = viewModel else {
            XCTFail("ViewModel not correctly initialized")
            return
        }
        
        let delegate = StargazersVMDelegate(viewModel: vm,
                                            expectation: expectation,
                                            onCompletionBlock: {
                                                XCTFail("Request should not call onCompletionBlock")
                                            },
                                            onErrorBlock: { errorMessage in
                                                XCTAssertEqual(errorMessage, "Errore vuoto")
                                            },
                                            isLoadingMoreBlock: { isLoading in
                                                XCTFail("Request should not call isLoadingMoreBlock")
                                            })
        
        vm.delegate = delegate
        
        vm.fetchStargazers(for: "octocat/hello-world")
        waitForExpectations(timeout: 10)
    }
    
    func testCorrectData() throws {
        
        let expectation = self.expectation(description: "Request should succeed returning stargazers")
        let originalURL = URL(string: "https://api.github.com/repos/octocat/hello-world/stargazers")!
        
        Mock(url: originalURL, ignoreQuery: true, dataType: .json, statusCode: 200, data: [
            .get: MockedData.correctData.data
        ]).register()
        
        guard let vm = viewModel else {
            XCTFail("ViewModel not correctly initialized")
            return
        }
        
        let delegate = StargazersVMDelegate(viewModel: vm,
                                            expectation: expectation,
                                            onCompletionBlock: {
                                                XCTAssertEqual(vm.stargazers.isEmpty, false)
                                                XCTAssertEqual(vm.stargazers.count, 2)
                                                XCTAssertEqual(vm.stargazers.first?.login, "allanmaio")
                                            },
                                            onErrorBlock: { errorMessage in
                                                XCTFail("Request should not call onErrorBlock with message: \(errorMessage)")
                                            },
                                            isLoadingMoreBlock: { isLoading in
                                                XCTFail("Request should not call isLoadingMoreBlock")
                                            })
        
        vm.delegate = delegate
        
        vm.fetchStargazers(for: "octocat/hello-world")
        waitForExpectations(timeout: 1)
    }
    
    func testPaginationData() throws {
        
        let expectation = self.expectation(description: "Request should succeed returning stargazers")
        let firstPageURL = URL(string: "https://api.github.com/repos/octocat/hello-world/stargazers?per_page=10&page=1")!
        let secondPageURL = URL(string: "https://api.github.com/repos/octocat/hello-world/stargazers?per_page=10&page=2")!
        
        Mock(url: firstPageURL, ignoreQuery: false, dataType: .json, statusCode: 200, data: [
            .get: MockedData.correctData.data
        ]).register()
        
        
        Mock(url: secondPageURL, ignoreQuery: false, dataType: .json, statusCode: 200, data: [
            .get: MockedData.correctData.data
        ]).register()
        
        guard let vm = viewModel else {
            XCTFail("ViewModel not correctly initialized")
            return
        }
        
        let delegate = StargazersVMDelegate(viewModel: vm,
                                            expectation: expectation,
                                            onCompletionBlock: {
                                                XCTAssertEqual(vm.stargazers.isEmpty, false)
                                                XCTAssertEqual(vm.stargazers.count, 2)
                                                XCTAssertEqual(vm.stargazers.first?.login, "allanmaio")
                                            },
                                            onErrorBlock: { errorMessage in
                                                XCTFail("Request should not call onErrorBlock with message: \(errorMessage)")
                                            },
                                            isLoadingMoreBlock: { isLoading in
                                                XCTFail("Request should not call isLoadingMoreBlock")
                                            })
        
        vm.delegate = delegate
        
        vm.fetchStargazers(for: "octocat/hello-world")
        vm.fetchStargazers(for: "octocat/hello-world")
        
        waitForExpectations(timeout: 10)
    }
}
