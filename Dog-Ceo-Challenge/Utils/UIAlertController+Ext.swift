//
//  UIAlertController+Ext.swift
//  Dog-Ceo-Challenge
//
//  Created by Pipe Carrasco on 15-08-21.
//

import UIKit

extension UIViewController {
  /// Muestra un alertcontroller con una única acción
  /// - Parameters:
  ///  - alertMessage: Mensaje del alert
  ///  - alertTitle: Título del alert
  ///  - alertActionTitle: Título de la acción
  func showAlert(alertMessage: String,
                 alertTitle: String = "Error".localized,
                 alertActionTitle: String = "OK".localized) {
    let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
    alertController.addAction(UIAlertAction(title: alertActionTitle, style: .default, handler: nil))
    present(alertController, animated: true, completion: nil)
  }
}
