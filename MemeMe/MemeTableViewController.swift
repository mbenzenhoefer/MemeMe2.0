//
//  MemeTableViewController.swift
//  MemeMe
//
//  Created by Benzenhoefer, Moritz (059) on 04.03.21.
//

import Foundation
import UIKit

class MemeTableViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var memeTable: UITableView!
    
    private var plusButton: UIBarButtonItem?
    
    var storedMemes: [Meme]? {
        return (UIApplication.shared.delegate as? AppDelegate)?.storedMemes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        memeTable.delegate = self
        memeTable.dataSource = self
        
        plusButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addMeme))
        navigationItem.rightBarButtonItem = plusButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        memeTable.reloadData()
        
        togglePlaceholder()
    }
    
    @objc func addMeme() {
        let addController = storyboard?.instantiateViewController(withIdentifier: "MemeCreatorViewController")
        
        if let addController = addController {
            navigationController?.pushViewController(addController, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storedMemes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let memeDetailViewController = storyboard?.instantiateViewController(withIdentifier: "MemeViewController") as? MemeViewController
        
        if let memeDetailViewController = memeDetailViewController {
            memeDetailViewController.meme = storedMemes?[indexPath.row].memedImage
            navigationController?.pushViewController(memeDetailViewController, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let memeCell = tableView.dequeueReusableCell(withIdentifier: "MemeTableCell") as! MemeTableCell
        
        let meme = storedMemes?[indexPath.row]
        
        if let meme = meme {
            memeCell.memeLabel?.text = buildMemeTitle(meme)
            memeCell.memeImageView?.image = meme.memedImage
        }
        
        return memeCell
    }
    
    private func togglePlaceholder() {
        if storedMemes?.count == 0 {
            memeTable.setNoDataPlaceholder("No Memes created yet. Go ahead and create one :-)")
        } else {
            memeTable.removeNoDataPlaceholder()
        }
    }
    
    private func buildMemeTitle(_ meme: Meme) -> String {
        return "\(meme.topText)...\(meme.bottomText)"
    }
}

class MemeTableCell : UITableViewCell {
    @IBOutlet weak var memeImageView: UIImageView!
    @IBOutlet weak var memeLabel: UILabel!
}
