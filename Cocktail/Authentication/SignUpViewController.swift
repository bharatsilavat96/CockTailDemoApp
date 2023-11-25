//
//  SignUpViewController.swift
//  Cocktail
//
//  Created by Bharat Silavat on 11/03/23.
//

import UIKit
import Foundation



class SignUpViewController: UIViewController {
    
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var newUserFirstNameView : UIView!
    @IBOutlet weak var newUserLastView: UIView!
    @IBOutlet weak var newUserAgeView: UIView!
    @IBOutlet weak var newUserCountryView: UIView!
    @IBOutlet weak var newUserEmailView: UIView!
    @IBOutlet weak var newUserPassView: UIView!
    @IBOutlet weak var newUserFirstNameFld: UITextField!
    @IBOutlet weak var newUserLastNameFld: UITextField!
    @IBOutlet weak var newUserAgeFld: UITextField!
    @IBOutlet weak var newUserEmailFld: UITextField!
    @IBOutlet weak var newUserPassFld: UITextField!
    @IBOutlet weak var newUserCountryFld: UITextField!
    @IBOutlet weak var topView: UIView!
    let agePicker = UIPickerView()
    let ageData = Array(1...100)
    let countryPicker = UIPickerView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addRandomGradient()
        print("SignUpController ViewDidLoad")
        changeUi()
        agePicker.delegate = self
        agePicker.dataSource = self
        countryPicker.delegate = self
        countryPicker.dataSource = self
        newUserAgeFld.inputView = agePicker
        newUserCountryFld.inputView = countryPicker
        let countryToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
        let countryDoneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        countryToolbar.setItems([countryDoneButton], animated: true)
        newUserCountryFld.inputAccessoryView = countryToolbar
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        toolbar.setItems([doneButton], animated: true)
        newUserAgeFld.inputAccessoryView = toolbar
    }
    var countries = [
        "Afghanistan","Albania","Algeria","Andorra","Angola","Antigua and Barbuda","Argentina","Armenia","Australia","Austria","Azerbaijan","Bahamas","Bahrain","Bangladesh","Barbados","Belarus","Belgium","Belize","Benin","Bhutan","Bolivia","Bosnia and Herzegovina","Botswana","Brazil","Brunei","Bulgaria","Burkina Faso","Burundi","Cabo Verde","Cambodia","Cameroon","Canada","Central African Republic","Chad","Chile","China","Colombia","Comoros","Congo, Democratic Republic of the","Congo, Republic of the","Costa Rica","Cote d'Ivoire","Croatia","Cuba","Cyprus","Czech Republic","Denmark","Djibouti","Dominica","Dominican Republic","Ecuador","Egypt","El Salvador","Equatorial Guinea","Eritrea","Estonia","Eswatini","Ethiopia","Fiji","Finland","France","Gabon","Gambia","Georgia","Germany","Ghana","Greece","Grenada","Guatemala","Guinea","Guinea-Bissau","Guyana","Haiti","Honduras","Hungary","Iceland","India","Indonesia","Iran","Iraq","Ireland","Israel","Italy","Jamaica","Japan","Jordan","Kazakhstan","Kenya","Kiribati","Kosovo","Kuwait","Kyrgyzstan","Laos","Latvia","Lebanon","Lesotho","Liberia","Libya","Liechtenstein","Lithuania","Luxembourg","Madagascar","Malawi","Malaysia","Maldives","Mali","Malta","Marshall Islands","Mauritania","Mauritius","Mexico","Micronesia","Moldova","Monaco","Mongolia","Montenegro","Morocco","Mozambique","Myanmar (Burma)","Namibia","Nauru","Nepal","Netherlands","New Zealand","Nicaragua","Niger","Nigeria","North Korea","North Macedonia (formerly Macedonia)","Norway","Oman","Pakistan","Palau","Palestine","Panama","Papua New Guinea"]
    
    
    @IBAction func SignUpAction(sender: UIButton){
        
        let userData = UserModel(firstName: newUserFirstNameFld.text, lastName: newUserLastNameFld.text, country: newUserCountryFld.text, email: newUserEmailFld.text, password: newUserPassFld.text, age: newUserAgeFld.text)
        do {
            let encoder = JSONEncoder()
            let encodedData = try encoder.encode(userData)
            UserDefaults.standard.set(encodedData, forKey: "userData")
            print("Data saved successfully.")
        } catch {
            print("Failed to encode data.")
        }
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    @IBAction func alreadyHaveAccountAction(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        vc.modalPresentationStyle = .fullScreen
        print("AlreadyHave Account Btn Tapped")
        present(vc, animated: true)
    }
    
}
extension SignUpViewController: UITextFieldDelegate {
    
    func changeUi(){
        newUserFirstNameFld.delegate = self
        newUserLastNameFld.delegate = self
        newUserAgeFld.delegate = self
        newUserEmailFld.delegate = self
        newUserPassFld.delegate = self
        newUserCountryFld.delegate = self
        signUpBtn.addRandomGradient()
        signUpBtn.layer.masksToBounds = true
        signUpBtn.layer.borderWidth = 2
        signUpBtn.layer.borderColor = UIColor.red.cgColor
        newUserFirstNameView.layer.masksToBounds = true
        newUserLastView.layer.masksToBounds = true
        newUserAgeView.layer.masksToBounds = true
        newUserCountryView.layer.masksToBounds = true
        newUserEmailView.layer.masksToBounds = true
        newUserPassView.layer.masksToBounds = true
        newUserFirstNameFld.layer.masksToBounds = true
        newUserLastNameFld.layer.masksToBounds = true
        newUserAgeFld.layer.masksToBounds = true
        newUserEmailFld.layer.masksToBounds = true
        newUserPassFld.layer.masksToBounds = true
        newUserCountryFld.layer.masksToBounds = true
        
        newUserFirstNameView.layer.cornerRadius = 10
        newUserLastView.layer.cornerRadius = 10
        newUserAgeView.layer.cornerRadius = 10
        newUserCountryView.layer.cornerRadius = 10
        newUserEmailView.layer.cornerRadius = 10
        newUserPassView.layer.cornerRadius = 10
        
        newUserFirstNameView.layer.borderWidth = 2
        newUserLastView.layer.borderWidth = 2
        newUserAgeView.layer.borderWidth = 2
        newUserCountryView.layer.borderWidth = 2
        newUserEmailView.layer.borderWidth = 2
        newUserPassView.layer.borderWidth = 2
        
    }
    
    //MARK: - Managing textFieldColors -
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if (textField == newUserFirstNameFld) {
            newUserFirstNameView.layer.borderColor = UIColor(red: 124.0, green: 252.0, blue: 0.0, alpha: 1).cgColor
        }
        if (textField == newUserLastNameFld) {
            newUserLastView.layer.borderColor = UIColor(red: 124.0, green: 252.0, blue:0.0, alpha: 1).cgColor
        }
        if (textField == newUserAgeFld) {
            newUserAgeView.layer.borderColor = UIColor(red: 124.0, green: 252.0, blue:0.0, alpha: 1).cgColor
        }
        if (textField == newUserEmailFld) {
            newUserCountryView.layer.borderColor = UIColor(red: 124.0, green: 252.0, blue:0.0, alpha: 1).cgColor
        }
        if (textField == newUserPassFld) {
            newUserEmailView.layer.borderColor = UIColor(red: 124.0, green: 252.0, blue:0.0, alpha: 1).cgColor
        }
        if (textField == newUserCountryFld) {
            newUserPassView.layer.borderColor = UIColor(red: 124.0, green: 252.0, blue:0.0, alpha: 1).cgColor
        }
        
    }
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if (textField == newUserFirstNameFld) {
            newUserFirstNameView.layer.borderColor = UIColor.white.cgColor
        }
        if (textField == newUserLastNameFld) {
            newUserLastView.layer.borderColor = UIColor.white.cgColor
        }
        if (textField == newUserAgeFld) {
            newUserAgeView.layer.borderColor = UIColor.white.cgColor
        }
        if (textField == newUserEmailFld) {
            newUserCountryView.layer.borderColor = UIColor.white.cgColor
        }
        if (textField == newUserPassFld) {
            newUserPassView.layer.borderColor = UIColor.white.cgColor
        }
        if (textField == newUserCountryFld) {
            newUserPassView.layer.borderColor = UIColor.white.cgColor
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("TextField should return method called")
        textField.resignFirstResponder();
        return true
    }
    
}
extension SignUpViewController: UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == countryPicker{
            return countries.count
        }
        else if pickerView == agePicker {
            return ageData.count
        } else{
            return 0
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == agePicker {
            return "\(ageData[row])"
        }
       else if pickerView == countryPicker{
            return countries[row]
        }else{
            return "No Data Found"
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == countryPicker {
            newUserCountryFld.text = "\(countries[row])"
        }
        if let ageText = newUserAgeFld.text, !ageText.isEmpty, let age = Int(ageText), age <= 17 {
            newUserAgeFld.textColor = .red
            newUserAgeFld.text = "\(ageData[row])"
        } else {
            newUserAgeFld.text = "\(ageData[row])"
        }
    }
    @objc func doneButtonTapped() {
        newUserCountryFld.resignFirstResponder()
        newUserAgeFld.resignFirstResponder()
        
    }
}
