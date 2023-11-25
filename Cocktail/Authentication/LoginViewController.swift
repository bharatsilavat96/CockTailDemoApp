//
//  LoginViewController.swift
//  Cocktail
//
//  Created by Bharat Silavat on 09/03/23.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var userPass: UITextField!
    @IBOutlet weak var userEmailView: UIControl!
    @IBOutlet weak var userPasView: UIControl!
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var forgotPassBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var passBtnShow: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addRandomGradient()
        print("LoginViewController ViewDidLoad")
        setupViews()
        userPass.delegate = self
        userEmail.delegate = self
        userPass.isSecureTextEntry = true
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func getEmailAndPasswordDict() -> [String: String] {
        if let savedData = UserDefaults.standard.data(forKey: "userData") {
            let decoder = JSONDecoder()
            if let loadedData = try? decoder.decode(UserModel.self, from: savedData) {
                let email = "\(loadedData.email!)"
                let password = "\(loadedData.password!)"
                if (email.isEmpty && password.isEmpty) == false{
                    return ["email": email, "password": password]
                }
            } else {
                userEmail.textColor = .red
                userEmail.text = "Please Enter Valid Email/Password"
                print("Failed to retrieveData")
            }
        } else {
            print("No saved data found.")
        }
        return [:]
    }
    
    @IBAction func loginAction(sender: UIButton){
        
//        let emailAndPass = getEmailAndPasswordDict()
//        print(emailAndPass)
//        let email = emailAndPass["email"]
//        let password = emailAndPass["password"]
//        if email == userEmail.text && password == userPass.text{
//            UserDefaults.standard.set(true, forKey: "isLoggedIn")
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "CocktailTabBarController") as! CocktailTabBarController
            
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
//        }
    }
    @IBAction func signUpBtnAction(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    
    @IBAction func forgotBtnAction(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ForgotPassViewController") as! ForgotPassViewController
        vc.modalPresentationStyle = .popover
        present(vc, animated: true)
    }
    @IBAction func showBtnAction(_ sender: UIButton) {
        sender.isSelected.toggle()
        if sender.isSelected{
            userPass.isSecureTextEntry = false
        }else {
            userPass.isSecureTextEntry = true
        }
    }
}
extension LoginViewController {
    private func setupViews() {
        loginBtn.layer.cornerRadius = 12.0
        loginBtn.layer.borderWidth = 1.0
        loginBtn.layer.borderColor = UIColor.red.cgColor
        
        userEmailView.layer.cornerRadius = 12.0
        userEmailView.layer.borderWidth = 1.0
        userEmailView.layer.borderColor = UIColor.red.cgColor
        
        userPasView.layer.cornerRadius = 12.0
        userPasView.layer.borderWidth = 1.0
        userPasView.layer.borderColor = UIColor.red.cgColor
    }
}
extension LoginViewController: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if (textField == userEmail) {
            userEmailView.layer.borderColor = UIColor(red: 124.0, green: 252.0, blue: 0.0, alpha: 1).cgColor
        }
        if (textField == userPass) {
            userPasView.layer.borderColor = UIColor(red: 124.0, green: 252.0, blue:0.0, alpha: 1).cgColor
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if (textField == userEmail) {
            userEmailView.layer.borderColor = UIColor.white.cgColor
        }
        if (textField == userPass) {
            userPasView.layer.borderColor = UIColor.white.cgColor
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @objc func keyboardWillShow(notification:NSNotification) {
        
        guard let userInfo = notification.userInfo else { return }
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        var contentInset:UIEdgeInsets = self.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height + 20
        scrollView.contentInset = contentInset
    }
    
    @objc func keyboardWillHide(notification:NSNotification) {
        
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
    }
}
