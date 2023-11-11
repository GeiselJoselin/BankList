//
//  BanksCell.swift
//  BankListApp
//
//  Created by Geisel Roque on 11/11/23.
//

import UIKit

class BanksCell: UITableViewCell {
  var item: BanksListModel? {
    didSet { setCell() }
  }
  
  private lazy var bankName: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .boldSystemFont(ofSize: 16)
    return label
  }()
  
  private lazy var bankDescription: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .systemFont(ofSize: 12)
    label.numberOfLines = 0
    return label
  }()
  
  private lazy var bankAge: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .systemFont(ofSize: 12)
    return label
  }()
  
  private lazy var bankURL: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .blue
    label.isUserInteractionEnabled = true
    label.font = .systemFont(ofSize: 12)
    label.numberOfLines = 0
    return label
  }()

  private lazy var borderLine: UIView = {
    let view = UIView()
    view.heightAnchor.constraint(equalToConstant: 1).isActive = true
    view.backgroundColor = .black
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  let stackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.distribution = .fillProportionally
    stackView.spacing = 4
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupUI()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupUI()
  }
  
  private func setupUI() {
    addSubview(stackView)
    stackView.addArrangedSubview(bankName)
    stackView.addArrangedSubview(bankDescription)
    stackView.addArrangedSubview(bankAge)
    stackView.addArrangedSubview(bankURL)
    stackView.addArrangedSubview(borderLine)
    
    NSLayoutConstraint.activate([
      stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
      stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
      stackView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
      stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 8)
    ])
  }
  
  override class func awakeFromNib() {
    super.awakeFromNib()
  }
  
  func setCell() {
    guard let item else { return }
    bankName.text = "Nombre: \(item.bankName)"
    bankDescription.text = "Descripcion: \(item.description)"
    bankAge.text = "Antiguedad: \(item.age) Años"
    bankURL.text = "Link: \(item.url)"
  }
}
