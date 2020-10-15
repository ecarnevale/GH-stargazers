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

    override func setUp() {
        super.setUp()
        configuration.protocolClasses = [MockingURLProtocol.self]
    }

    override func tearDown()  {
        super.tearDown()
    }

    func testRepoNotFound() throws {
        
        let expectation = self.expectation(description: "Request should return error with Not Found message")
        let originalURL = URL(string: "https://api.github.com/repos/octocat/hello-wo/stargazers")!
        
        Mock(url: originalURL, ignoreQuery: true, dataType: .json, statusCode: 200, data: [
            .get: MockedData.notFoundRepo.data
        ]).register()
        
        let vm = StargazerViewModel(configuration: configuration)
        
        let delegate = StargazersVMDelegate(viewModel: vm,
                                            expectation: expectation,
                                            onCompletionBlock: {
                                                XCTFail("Request should not call onCompletion")
                                            },
                                            onErrorBlock: { errorMessage in
                                                XCTAssertEqual(vm.stargazers.isEmpty, true)
                                                XCTAssertEqual(errorMessage, "Not Found" )
                                                expectation.fulfill()
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
        
        let vm = StargazerViewModel(configuration: configuration)
        
        let delegate = StargazersVMDelegate(viewModel: vm,
                                            expectation: expectation,
                                            onCompletionBlock: {
                                                XCTFail("Request should not call onCompletionBlock")
                                            },
                                            onErrorBlock: { errorMessage in
                                                XCTAssertEqual(errorMessage, "Non sono stati trovati stargazers")
                                                expectation.fulfill()
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
        
        let vm = StargazerViewModel(configuration: configuration)
        
        let delegate = StargazersVMDelegate(viewModel: vm,
                                            expectation: expectation,
                                            onCompletionBlock: {
                                                XCTAssertEqual(vm.stargazers.isEmpty, false)
                                                XCTAssertEqual(vm.stargazers.count, 2)
                                                XCTAssertEqual(vm.stargazers.first?.login, "correct1")
                                                expectation.fulfill()
                                            },
                                            onErrorBlock: { errorMessage in
                                                XCTFail("Request should not call onErrorBlock with message: \(errorMessage)")
                                            },
                                            isLoadingMoreBlock: { isLoading in
                                                XCTFail("Request should not call isLoadingMoreBlock")
                                            })
        
        vm.delegate = delegate
        
        vm.fetchStargazers(for: "octocat/hello-world")
        waitForExpectations(timeout: 5)
    }
    
    func testPaginationData() throws {
        
        let expectation = self.expectation(description: "Request should succeed returning stargazers")
        let firstPageURL = URL(string: "https://api.github.com/repos/alamofire/alamofire/stargazers?per_page=10&page=1")!
        let secondPageURL = URL(string: "https://api.github.com/repos/alamofire/alamofire/stargazers?per_page=10&page=2")!
        
        Mock(url: firstPageURL, ignoreQuery: false, dataType: .json, statusCode: 200, data: [
            .get: MockedData.paginationData.data
        ]).register()
        
        
        Mock(url: secondPageURL, ignoreQuery: false, dataType: .json, statusCode: 200, data: [
            .get: MockedData.paginationData2.data
        ]).register()
        
        let vm = StargazerViewModel(configuration: configuration)
        
        var callNumber = 1
        
        let delegate = StargazersVMDelegate(viewModel: vm,
                                            expectation: expectation,
                                            onCompletionBlock: {
                                                if callNumber == 1 {
                                                    XCTAssertEqual(vm.stargazers.isEmpty, false)
                                                    XCTAssertEqual(vm.stargazers.count, 2)
                                                    XCTAssertEqual(vm.stargazers.first?.login, "pagination1")
                                                    
                                                    // perform second call
                                                    callNumber = 2
                                                    vm.fetchStargazers(for: "alamofire/alamofire")
                                                    
                                                } else {
                                                    XCTAssertEqual(vm.stargazers.isEmpty, false)
                                                    XCTAssertEqual(vm.stargazers.count, 5)
                                                    XCTAssertEqual(vm.stargazers.first?.login, "pagination1")
                                                    expectation.fulfill()
                                                }
                                            },
                                            onErrorBlock: { errorMessage in
                                                XCTFail("Request should not call onErrorBlock with message: \(errorMessage)")
                                            },
                                            isLoadingMoreBlock: { isLoading in
                                                if callNumber == 1 {
                                                    XCTFail("Request should not call isLoadingMoreBlock")
                                                } else {
                                                    XCTAssertTrue(isLoading)
                                                }
                                            })
        
        vm.delegate = delegate
        
        vm.fetchStargazers(for: "alamofire/alamofire")
        
        waitForExpectations(timeout: 10)
    }
}
