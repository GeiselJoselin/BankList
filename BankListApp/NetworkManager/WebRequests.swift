//
//  WebRequests.swift
//  BankListApp
//
//  Created by Geisel Roque on 11/11/23.
//

import Foundation
import UIKit

class WebRequests: NSObject {
  
  static var baseURL: String {
    get { return development }
  }
  
  static let development = "https://dev.obtenmas.com/catom/api/challenge/banks"

  public enum ServiciosWeb: String {
    case WSExample = ""
  }
  
  /// Función que nos permite obtener URL de nuestro servicio
  ///
  /// - Parameter method: obtiene los servicios disponibles
  /// - Returns: devuelve nuestra URL en un string
  static func getURL() -> String? {
    var requestURL: String

    requestURL = baseURL
    return requestURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
  }
}
