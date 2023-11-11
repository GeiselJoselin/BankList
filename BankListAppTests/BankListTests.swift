//
//  BankListTests.swift
//  BankListAppTests
//
//  Created by Geisel Roque on 11/11/23.
//

import Foundation
import XCTest
@testable import BankListApp

class BanksListTests: XCTestCase {
  
  // MARK: - ViewModel Tests
  func testFetchBanksSuccess() {
    let viewModel = BanksListViewModel()
    
    let expectation = XCTestExpectation(description: "Fetch banks completion")
    
    viewModel.getBanks {
      expectation.fulfill()
    }
    
    wait(for: [expectation], timeout: 5.0)
    
    XCTAssertFalse(viewModel.getInfoBanks().isEmpty)
    XCTAssertEqual(viewModel.getError(), "No banks to show")
  }
  
  func testFetchBanksFailure() {
    let viewModel = BanksListViewModel()
    
    let expectation = XCTestExpectation(description: "Fetch banks completion")
    
    let api = ApiServiceMock()
    api.fetchBanksResult = .failure(Constants.notFoundError)
    viewModel.apiService = api
    
    viewModel.getBanks {
      expectation.fulfill()
    }
    
    XCTAssertTrue(viewModel.getInfoBanks().isEmpty)
    XCTAssertEqual(viewModel.getError(), Constants.notFoundError.localizedDescription)
  }
  
  // MARK: - ApiService Tests
  
  func testApiServiceFetchBanksSuccess() {
    let expectation = XCTestExpectation(description: "Fetch banks completion")
    
    ApiService().fetchBanks { result in
      switch result {
      case .success(let banks):
        XCTAssertNotNil(banks)
      case .failure(let error):
        XCTFail("Unexpected error: \(error.localizedDescription)")
      }
      expectation.fulfill()
    }
    wait(for: [expectation], timeout: 5.0)
  }
  
  // MARK: - ViewController Tests
  func testViewControllerDidLoad() {
    let viewController = BanksListViewController()
    _ = viewController.view
    
    XCTAssertEqual(viewController.titleBank.text, "Bank List")
    XCTAssertNotNil(viewController.tableView)
  }
  
  // MARK: - Helpers
  class ApiServiceMock: ApiServiceProtocol {
    var fetchBanksResult: Result<[BanksListModel]?, Error> = .success([])

    func fetchBanks(completion: @escaping (Result<[BanksListModel]?, Error>) -> Void) {
      completion(fetchBanksResult)
    }
  }
}
