//
//  MemeCollectionViewController.swift
//  MemeMe
//
//  Created by Benzenhoefer, Moritz (059) on 04.03.21.
//

import Foundation
import UIKit

class MemeCollectionViewController : SentMemesViewController {

    //MARK: UI references
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    @IBOutlet var memeCollection: UICollectionView!
    
    @IBAction func addMeme(_ sender: Any) {
        showMemeEditor()
    }
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        memeCollection.delegate = self
        memeCollection.dataSource = self
        
        setFlowLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        memeCollection.reloadData()
        
        togglePlaceholder()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        super.viewWillTransition(to: size, with: coordinator)
        // we wait for rotation to be done until we reevaluate
        coordinator.animate(alongsideTransition: nil) { (context) in
            self.setFlowLayout()
        }
    }
    
    private func togglePlaceholder() {
        if storedMemes?.count == 0 {
            memeCollection.setNoDataPlaceholder("No Memes created yet. Go ahead and create one :-)")
        } else {
            memeCollection.removeNoDataPlaceholder()
        }
    }
}

//MARK: Collection View
extension MemeCollectionViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showMemeDetail(meme: storedMemes?[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let memeCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionViewCell", for: indexPath)
            as? MemeCollectionViewCell {
            memeCell.memeImageView.image = storedMemes?[indexPath.row].memedImage
            return memeCell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return storedMemes?.count ?? 0
    }
}

//MARK: UI manipulation
extension MemeCollectionViewController {
    
    func setFlowLayout() {
        var itemsPerRow: CGFloat = 4
        
        if UIDevice.current.orientation.isLandscape {
            itemsPerRow = 7
        }
        
        let space: CGFloat = 3.0
        
        let dimension = (view.frame.size.width - ((itemsPerRow-1) * space)) / itemsPerRow
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
    }
}

//MARK: Cell
class MemeCollectionViewCell : UICollectionViewCell {
    
    @IBOutlet weak var memeImageView: UIImageView!
}
