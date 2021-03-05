//
//  MemeTextDelegate.swift
//  MemeMe
//
//  Created by Benzenhoefer, Moritz (059) on 03.03.21.
//

import Foundation
import UIKit

class MemeTextDelegate : NSObject, UITextFieldDelegate {
       
    let initialText: String
    
    init(initialText: String) {
        self.initialText = initialText
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == initialText {
            textField.text = ""
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        if string.isEmpty {
            textField.deleteBackward()
        } else {
            // we want to uppercase every letter, also pasted
            textField.insertText(string.uppercased())
        }
        
        return false
    }
    
}
