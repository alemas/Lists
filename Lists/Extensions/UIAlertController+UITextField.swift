//
//  UIAlertController+UITextField.swift
//  Lists
//
//  Created by Mateus Reckziegel on 31/05/21.
//

import Foundation
import UIKit

extension UIAlertController: UITextFieldDelegate {
    convenience init(title: String?, message: String?, preferredStyle: UIAlertController.Style,
                     successAction: UIAlertAction, txtFieldPlaceholder: String?) {
        self.init(title: title, message: message, preferredStyle: preferredStyle)
        
        self.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        successAction.isEnabled = false
        self.addAction(successAction)
        self.preferredAction = successAction
        
        self.addTextField { txtField in
            txtField.placeholder = txtFieldPlaceholder
            txtField.delegate = self
        }
    }

    public func textFieldDidChangeSelection(_ textField: UITextField) {
        if let text = textField.text {
            self.preferredAction?.isEnabled = !text.isEmpty
        } else {
            self.preferredAction?.isEnabled = false
        }
    }
}
