//
//  Response.swift
//  BankListApp
//
//  Created by Geisel Roque on 11/11/23.
//

import UIKit

struct Response <T:Codable>: Codable {
  var response: T?

  enum CodingKeys: String, CodingKey {
    case response
  }
}
