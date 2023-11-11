//
//  BanksListViewController.swift
//  BankListApp
//
//  Created by Geisel Roque on 11/11/23.
//

import UIKit

class BanksListViewController: UIViewController {
  // MARK: - Variables
  private let viewModel = BanksListViewModel()
  private var banks = [BanksListModel]()

  // MARK: - UIComponents
  private(set) lazy var tableView: UITableView = {
    var tableView = UITableView()
    tableView.register(BanksCell.self, forCellReuseIdentifier: "BanksCell")
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.delegate = self
    tableView.dataSource = self
    tableView.separatorStyle = .none
    return tableView
  }()

  private(set) lazy var titleBank: UILabel = {
    var title = UILabel()
    title.translatesAutoresizingMaskIntoConstraints = false
    title.text = "Bank List"
    return title
  }()

  // MARK: - Override functions
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    configureConstraints()
    fetchBanks()
  }

  // MARK: - private functions
  private func configureConstraints() {
    view.addSubview(tableView)
    view.addSubview(titleBank)

    NSLayoutConstraint.activate([
      titleBank.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
      titleBank.centerXAnchor.constraint(equalTo: view.centerXAnchor),

      tableView.topAnchor.constraint(equalTo: titleBank.bottomAnchor, constant: 12),
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -48)
    ])
  }

  private func fetchBanks() {
    self.viewModel.getBanks {
      DispatchQueue.main.async { [weak self] in
        guard let self, !self.viewModel.getInfoBanks().isEmpty else {
          self?.showErrorAlert(message: self?.viewModel.getError() ?? "")
          return
        }
        self.tableView.reloadData()
      }
    }
  }

  private func showErrorAlert(message: String) {
    DispatchQueue.main.async { [weak self] in
      let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
      let okAction = UIAlertAction(title: "Accept", style: .default, handler: nil)
      alertController.addAction(okAction)
      self?.present(alertController, animated: true, completion: nil)
    }
  }
}

extension BanksListViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    viewModel.getInfoBanks().count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "BanksCell", for: indexPath) as? BanksCell else { return UITableViewCell() }
    let banks = viewModel.getInfoBanks()
    let bank = banks[indexPath.row]
    cell.item = bank
    return cell
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    180
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    let banks = viewModel.getInfoBanks()
    let bank = banks[indexPath.row]
    if let url = URL(string: bank.url) {
      UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
  }
}
