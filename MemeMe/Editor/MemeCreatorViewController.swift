//
//  MemeCreatorViewController.swift
//  MemeMe
//
//  Created by Benzenhoefer, Moritz (059) on 03.03.21.
//

import UIKit

class MemeCreatorViewController: UIViewController, UINavigationControllerDelegate {
    
    //MARK: UI references
    @IBOutlet weak var backgroundImage: UIImageView!

    @IBOutlet weak var cameraPickerButton: UIBarButtonItem!
    
    @IBOutlet weak var bottomToolbar: UIToolbar!
    
    @IBOutlet weak var topTextField: UITextField!
    
    @IBOutlet weak var bottomTextField: UITextField!
    
    private var shareButton: UIBarButtonItem?
    
    private var navCancelButton: UIBarButtonItem?
    
    //MARK: Constants
    private static let topDefaultText = "TOP"
    
    private static let bottomDefaultText = "BOTTOM"
    
    //MARK: Text related properties
    private let topTextDelegate = MemeTextDelegate(initialText: MemeCreatorViewController.topDefaultText)
    
    private let bottomTextDelegate = MemeTextDelegate(initialText: MemeCreatorViewController.bottomDefaultText)
    
    private let memeTextAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.strokeColor: UIColor.black,
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedString.Key.strokeWidth: -2.0
    ]
         
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        // hide Tab Bar
        hidesBottomBarWhenPushed = true
    }
    
    //MARK: Lifecycle related
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUi()        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        subscribeToKeyboardNotifications()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        unsubscribeFromKeyboardNotifications()
        
        super.viewWillDisappear(animated)
    }
    
    //MARK: Actions
    @objc func shareMeme() {
        buildMemeAndShare()
    }
    
    @objc func cancel() {
        showOverview()
    }

    @IBAction func pickFromAlbum(_ sender: Any) {
        chooseImage(type: .photoLibrary)
    }
    
    @IBAction func takePhoto(_ sender: Any) {
        chooseImage(type: .camera)
    }
    
    private func chooseImage(type: UIImagePickerController.SourceType) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = type
        
        present(picker, animated: true, completion: nil)
    }
    
    private func showOverview() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    //MARK: UI manipulation
    private func setupUi() {
        cameraPickerButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)

        shareButton = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(shareMeme))
        
        navCancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancel))

        navigationItem.leftBarButtonItem = shareButton
        navigationItem.rightBarButtonItem = navCancelButton
        
        configureTextViews(textView: topTextField, textDelegate: topTextDelegate, initialText: MemeCreatorViewController.topDefaultText)
        configureTextViews(textView: bottomTextField, textDelegate: bottomTextDelegate, initialText: MemeCreatorViewController.bottomDefaultText)
        
        configureUserActions(false)
    }
    
    private func configureTextViews(textView: UITextField,
                                    textDelegate: MemeTextDelegate,
                                    initialText: String) {
        textView.defaultTextAttributes = memeTextAttributes
        textView.text = initialText
        textView.textAlignment = NSTextAlignment.center
        textView.delegate = textDelegate
    }
    
    private func configureUserActions(_ imageSelected: Bool) {
        shareButton?.isEnabled = imageSelected
        topTextField.isEnabled = imageSelected
        bottomTextField.isEnabled = imageSelected
    }
    
    private func toggleShowMemeOnly(_ toggle: Bool) {
        navigationController?.setNavigationBarHidden(toggle, animated: false)
        bottomToolbar.isHidden = toggle
    }
    
    private func removeFocusFromTextFields() {
        // when you tap "share" directly when input still focused you may see the cursor in text
        // in the rendered image. Unfocusing will avoid this issue
        bottomTextField.resignFirstResponder()
        topTextField.resignFirstResponder()
    }
    
    //MARK: Keyboard related actions
    private func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        if bottomTextField.isFirstResponder {
            view.frame.origin.y = -getKeyboardHeight(notification)
        }
    }
    
    @objc private func keyboardWillHide() {
        view.frame.origin.y = 0
    }
    
    private func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        guard let keyboardSize = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
           return 0
        }

        return keyboardSize.cgRectValue.height
    }

}

//MARK: Generate Meme
extension MemeCreatorViewController {
    
    private func buildMemeAndShare() {
        removeFocusFromTextFields()
        if let backgroundImageResource = backgroundImage.image  {
            
            let memedImage = generateMemedImage()
            let shareController = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
            
            shareController.completionWithItemsHandler = { (activityType: UIActivity.ActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) -> Void in
                if completed {
                    self.saveMeme(backgroundImage: backgroundImageResource, memedImage: memedImage)
                    self.showOverview()
                }
            }
            
            present(shareController, animated: true, completion: nil)
        }
    }
    
    private func saveMeme(backgroundImage: UIImage, memedImage: UIImage) {
        let meme = Meme(
            topText: self.topTextField.text ?? "",
            bottomText: self.bottomTextField.text ?? "",
            originalImage: backgroundImage,
            memedImage: memedImage
        )
        
        (UIApplication.shared.delegate as? AppDelegate)?.storedMemes.append(meme)
    }
    
    private func generateMemedImage() -> UIImage {
        toggleShowMemeOnly(true)
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        toggleShowMemeOnly(false)
        
        return memedImage
    }
}

//MARK: Image Picker
extension MemeCreatorViewController : UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            backgroundImage.image = image
            configureUserActions(true)
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
