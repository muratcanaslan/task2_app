//
//  UIViewController+Ext.swift
//  task2_app
//
//  Created by Murat Can ASLAN on 28.08.2023.
//

import UIKit

extension UIViewController {
    func showMessage(message: String, action: UIAlertAction? = nil) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        if let action = action {
            alert.addAction(action)
        }
        alert.addAction(cancel)
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
}
