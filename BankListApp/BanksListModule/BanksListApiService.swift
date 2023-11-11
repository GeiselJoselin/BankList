//
//  BanksListApiService.swift
//  BankListApp
//
//  Created by Geisel Roque on 11/11/23.
//

import Foundation
protocol ApiServiceProtocol {
    func fetchBanks(completion: @escaping (Result<[BanksListModel]?, Error>) -> Void)
}

class ApiService: ApiServiceProtocol {
  func fetchBanks(completion: @escaping (Result<[BanksListModel]?, Error>) -> Void) {
    guard let urlService = WebRequests.getURL() else {
      completion(.failure(Constants.urlError))
      return
    }
    
    NetworkManager.shared.makeGetRequest(url: urlService) { (response: [BanksListModel]?, codeResponse: CodeResponse?) in
      switch codeResponse {
      case .ok:
          completion(.success(response))
      case .not_found:
        completion(.failure(Constants.notFoundError))
      case .not_connection:
        completion(.failure(Constants.connectivityError))
      case .authentication_failed:
        completion(.failure(Constants.authFailedError))
      default:
        let error = NSError(domain: "Error", code: codeResponse?.rawValue ?? -1, userInfo: ["message": "Error"])
        completion(.failure(error))
      }
    }
  }
}
