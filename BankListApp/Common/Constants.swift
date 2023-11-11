//
//  Constants.swift
//  BankListApp
//
//  Created by Geisel Roque on 11/11/23.
//

import Foundation

class Constants {
  static let urlError: NSError = NSError(domain: "url error", code: CodeResponse.bad_url.rawValue, userInfo: ["message": "url error"])
  static let connectivityError: NSError = NSError(domain: "Connection error", code: CodeResponse.not_connection.rawValue, userInfo: ["message": "Connection error"])
  static let notFoundError: NSError = NSError(domain: "Not Found", code: CodeResponse.not_found.rawValue, userInfo: ["message": "Not Found"])
  static let authFailedError: NSError = NSError(domain: "Auth Failed", code: CodeResponse.authentication_failed.rawValue, userInfo: ["message": "Auth Failed"])
}
