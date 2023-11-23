//
//  EditAccountViewController.swift
//  Cocktail
//
//  Created by Bharat Silavat on 12/03/23.
//

import UIKit

class EditAccountViewController: UIViewController {
    
    @IBOutlet weak var editDetailView: UIView!
    @IBOutlet weak var userDetailLbl: UILabel!
    @IBOutlet weak var editUserDataFld: UITextField!
    @IBOutlet weak var userInputTxtView: UITextView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gradientView()
        
    }
    
    func gradientView(){
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame.size = editDetailView.frame.size
        let fromColor = UIColor.red.cgColor
        let midColor = UIColor.yellow.cgColor
        let toColor = UIColor.blue.cgColor
        gradientLayer.colors = [fromColor,midColor,toColor]
        gradientLayer.masksToBounds = true
        gradientLayer.cornerRadius = 12
        editDetailView.layer.addSublayer(gradientLayer)
        editDetailView.addSubview(editUserDataFld)
        editDetailView.addSubview(userDetailLbl)
        editDetailView.addSubview(userInputTxtView)
    }
    
    
}
