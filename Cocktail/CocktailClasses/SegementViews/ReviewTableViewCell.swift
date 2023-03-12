//
//  ReviewTableViewCell.swift
//  Cocktail
//
//  Created by Bharat Silavat on 12/03/23.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var lastUpdateTimeLbl: UILabel!
    @IBOutlet weak var userProfilePicView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    @IBAction func deleteUser(sender: UIButton){
        
    }
    
    @IBAction func editReviewBtnAction(sender: UIButton){
        
    }
    
}
