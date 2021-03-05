//
//  EmptyView+Extension.swift
//  MemeMe
//
//  Created by Benzenhoefer, Moritz (059) on 04.03.21.
//

import Foundation
import UIKit

// highly inspired by https://blog.kulman.sk/simple-bindable-no-data-placeholder/
extension UITableView : EmptyView {
    func setNoDataPlaceholder(_ message: String) {
        isScrollEnabled = false
        backgroundView = buildLabelFor(message, width: self.bounds.size.width, height: self.bounds.size.height)
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

extension UICollectionView : EmptyView {
    func setNoDataPlaceholder(_ message: String) {
        isScrollEnabled = false
        backgroundView = buildLabelFor(message, width: self.bounds.size.width, height: self.bounds.size.height)
    }
}

extension UICollectionView {
    func removeNoDataPlaceholder() {
        isScrollEnabled = true
        backgroundView = nil
    }
}

protocol EmptyView {
    func buildLabelFor(_ message: String, width: CGFloat, height: CGFloat) -> UILabel
}

extension EmptyView {
    func buildLabelFor(_ message: String, width: CGFloat, height: CGFloat) -> UILabel {
        let noDataLabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: height))
        noDataLabel.text = message
        noDataLabel.sizeToFit()
        noDataLabel.lineBreakMode = .byWordWrapping
        noDataLabel.numberOfLines = 0
        noDataLabel.textAlignment = .center
        
        return noDataLabel
    }
}
