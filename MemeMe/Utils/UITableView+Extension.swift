//
//  UITableView+Extension.swift
//  MemeMe
//
//  Created by Benzenhoefer, Moritz (059) on 04.03.21.
//

import Foundation
import UIKit

// highly inspired by https://blog.kulman.sk/simple-bindable-no-data-placeholder/
extension UITableView {
    func setNoDataPlaceholder(_ message: String) {
        let noDataLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        noDataLabel.text = message
        noDataLabel.sizeToFit()
        noDataLabel.lineBreakMode = .byWordWrapping
        noDataLabel.numberOfLines = 0
        noDataLabel.textAlignment = .center

        isScrollEnabled = false
        backgroundView = noDataLabel
        separatorStyle = .none
    }
}

extension UITableView {
    func removeNoDataPlaceholder() {
        isScrollEnabled = true
        backgroundView = nil
        separatorStyle = .singleLine
    }
}

