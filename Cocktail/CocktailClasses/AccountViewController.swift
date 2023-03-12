//
//  AccountViewController.swift
//  Cocktail
//
//  Created by Bharat Silavat on 12/03/23.
//

import UIKit
import ContactsUI

class AccountViewController: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate, CNContactPickerDelegate {
    
    
    @IBOutlet weak var profileImgControl: UIControl!
    @IBOutlet weak var profileImgView: UIImageView!
    @IBOutlet weak var signOutBtn: UIButton!
    @IBOutlet weak var chageEmailControl: UIControl!
    @IBOutlet weak var inviteFrdControl: UIControl!
    @IBOutlet weak var contactUsControl: UIControl!
    @IBOutlet weak var writeReviewControl: UIControl!
    @IBOutlet weak var followUsControl: UIControl!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var reviewsLbl: UILabel!
    
    let imagePicker = UIImagePickerController()
    var downloadedImg: Data?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.showLoading()
        imagePicker.delegate = self
        self.removeLoading()
        
    }
    @objc func presentContactPicker() {
        let contactPickerVC = CNContactPickerViewController()
        contactPickerVC.delegate = self
        contactPickerVC.modalPresentationStyle = .fullScreen
        present(contactPickerVC, animated: true)
    }
    
    @IBAction func chnageEmailAction(_ sender: Any) {
        editViewPopPub()
    }
    
    @IBAction func inviteFriendAction(_ sender: Any) {
        contactUsControl.addTarget(self, action: #selector(presentContactPicker), for: .touchUpInside)
    }
    @IBAction func contactUsAction(_ sender: Any) {
        print("ContactBtn Clicked")
        if let url = URL(string: "https://maximess.com") {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func writeReviewAction(_ sender: Any) {
        editViewPopPub()
    }
    
    @IBAction func followUsAction(_ sender: Any) {
        if let url = URL(string: "https://maximess.com") {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func changeProfileImgAction(_ sender: Any) {
        profileImgControl.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
    }
    
    @IBAction func signOutAction(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.present(vc, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            var img = image.pngData()
            downloadedImg = img
            profileImgView.contentMode = .scaleAspectFill
            profileImgView.image = image
        }else {
            profileImgView.image = UIImage(named: "profileImageIcon")
        }
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    @objc func showAlert(){
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action) in
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true, completion: nil)
        }))
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action) in
                self.imagePicker.sourceType = .camera
                self.present(self.imagePicker, animated: true, completion: nil)
            }))
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @objc func editViewPopPub(){
        
        let popUpVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EditAccountViewController") as! EditAccountViewController
        popUpVc.modalPresentationStyle = .popover
        present(popUpVc, animated: true)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditAccountViewController"{
            segue.destination as! EditAccountViewController
        }
    }
    
    
}
