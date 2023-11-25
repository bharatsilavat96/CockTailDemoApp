//
//  ForgotPassViewController.swift
//  Cocktail
//
//  Created by Bharat Silavat on 11/03/23.
//

import UIKit

class ForgotPassViewController: UIViewController {
    
    @IBOutlet weak var newPassFld: UITextField!
    @IBOutlet weak var resetPassBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ForgotPassVC ViewDidLoad")
        self.view.addRandomGradient()
        self.resetPassBtn.addRandomGradient()
        
    }
    @IBAction func resetPassAction(_ sender: UIButton) {
        guard let data = UserDefaults.standard.data(forKey: "userData") else {return}
        do {
            let decoder = JSONDecoder()
            var savedUserData = try decoder.decode(UserModel.self, from: data)
            savedUserData.password = newPassFld.text
            let encoder = JSONEncoder()
            let encodedData = try encoder.encode(savedUserData)
            UserDefaults.standard.set(encodedData, forKey: "userData")
            print("Data saved successfully.")
        } catch {
            print("Failed to decode, update, encode, and save data to UserDefaults.")
        }
        dismiss(animated: true)
    }
}
