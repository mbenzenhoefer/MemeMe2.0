//
//  MemeTableViewController.swift
//  MemeMe
//
//  Created by Benzenhoefer, Moritz (059) on 04.03.21.
//

import Foundation
import UIKit

class MemeTableViewController : SentMemesViewController {
    
    //MARK: UI references
    @IBOutlet weak var memeTable: UITableView!
    
    @IBAction func addMeme(_ sender: Any) {
        showMemeEditor()
    }
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        memeTable.delegate = self
        memeTable.dataSource = self
        
        memeTable.rowHeight = UITableView.automaticDimension
        memeTable.estimatedRowHeight = 100
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        memeTable.reloadData()
        
        togglePlaceholder()
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

//MARK: Table View
extension MemeTableViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storedMemes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showMemeDetail(meme: storedMemes?[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
        if let memeCell = tableView.dequeueReusableCell(withIdentifier: "MemeTableCell") as? MemeTableCell,
           let meme = storedMemes?[indexPath.row] {
            memeCell.memeLabel?.text = buildMemeTitle(meme)
            memeCell.memeImageView?.image = meme.memedImage
            return memeCell
        } else {
            return UITableViewCell()
        }
    }
}

//MARK: Cell
class MemeTableCell : UITableViewCell {
    @IBOutlet weak var memeImageView: UIImageView!
    @IBOutlet weak var memeLabel: UILabel!
}
