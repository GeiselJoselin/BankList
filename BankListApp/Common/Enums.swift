//
//  Enums.swift
//  BankListApp
//
//  Created by Geisel Roque on 11/11/23.
//

import Foundation

public enum CodeResponse: Int {
  case ok = 200
  case bad_request = 400
  case authentication_failed = 401
  case not_found = 404
  case server_error = 500
  case unknow = 520
  case not_connection = 106
  case bad_url = -1
  case bad_decodable = -2
}
