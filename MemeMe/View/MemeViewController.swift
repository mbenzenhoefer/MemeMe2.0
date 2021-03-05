//
//  MemeViewController.swift
//  MemeMe
//
//  Created by Benzenhoefer, Moritz (059) on 04.03.21.
//

import Foundation
import UIKit

class MemeViewController : UIViewController {
    
    @IBOutlet weak var memeImageView: UIImageView!
    
    var meme: UIImage?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        // hide Tab Bar
        hidesBottomBarWhenPushed = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let meme = meme {
            memeImageView.image = meme
        }
    }
}
