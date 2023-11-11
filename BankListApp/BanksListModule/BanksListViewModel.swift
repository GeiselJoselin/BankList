//
//  BanksListViewModel.swift
//  BankListApp
//
//  Created by Geisel Roque on 11/11/23.
//

class BanksListViewModel {
  private var banks: [BanksListModel]? = []
  private var error: String = "No banks to show"
  var apiService: ApiServiceProtocol = ApiService()
  
  func getBanks(completion: @escaping () -> Void) {
    apiService.fetchBanks { [weak self] result in
      guard let self else { return }
      switch result {
      case .success(let banks):
        self.banks = banks
        completion()
      case .failure(let error):
        self.error = error.localizedDescription
      }
    }
  }

  func getInfoBanks() -> [BanksListModel] {
    banks ?? []
  }

  func getError() -> String {
    error
  }
}
