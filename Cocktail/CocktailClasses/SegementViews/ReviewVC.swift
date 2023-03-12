//
//  ReviewVC.swift
//  Cocktail
//
//  Created by Bharat Silavat on 12/03/23.
//

import UIKit

class ReviewVC: UIViewController {
    
    @IBOutlet weak var reviewTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reviewTableView.dataSource = self
        
    }
    
}
extension ReviewVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewTableViewCell", for: indexPath) as! ReviewTableViewCell
        return cell
    }
    
    
}
