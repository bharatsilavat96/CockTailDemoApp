//
//  LoderViewController.swift
//  Cocktail
//
//  Created by Bharat Silavat on 11/03/23.
//

import UIKit

class LoderViewController: UIViewController {
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        loadingIndicator.startAnimating()
    }
    override func viewDidDisappear(_ animated: Bool) {
        loadingIndicator.stopAnimating()
    }
}
extension UIViewController {
    func showLoading(){
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Login", bundle: nil)
        let loadingVC = storyboard.instantiateViewController(withIdentifier: "LoderViewController")
        loadingVC.view.tag = 100
        loadingVC.view.frame = self.view.bounds
        
        self.view.addSubview(loadingVC.view)
    }
    
    func removeLoading() {
        
        let views = self.view.subviews.filter({ $0.tag == 100 })
        if views.count > 0{
            let view = views[0]
            view.removeFromSuperview()
        }
    }
}
