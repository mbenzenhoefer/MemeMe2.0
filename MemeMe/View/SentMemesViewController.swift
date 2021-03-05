//
//  SentMemesViewController.swift
//  MemeMe
//
//  Created by Benzenhoefer, Moritz (059) on 05.03.21.
//

import Foundation
import UIKit

class SentMemesViewController : UIViewController {
    
    var storedMemes: [Meme]? {
        return (UIApplication.shared.delegate as? AppDelegate)?.storedMemes
    }
    
    func showMemeEditor() {
        let addController = storyboard?.instantiateViewController(withIdentifier: "MemeCreatorViewController")
        
        if let addController = addController {
            navigationController?.pushViewController(addController, animated: true)
        }
    }
    
    func showMemeDetail(meme: Meme?) {
        let memeDetailViewController = storyboard?.instantiateViewController(withIdentifier: "MemeViewController") as? MemeViewController
        
        if let memeDetailViewController = memeDetailViewController {
            memeDetailViewController.meme = meme?.memedImage
            navigationController?.pushViewController(memeDetailViewController, animated: true)
        }
    }
}
