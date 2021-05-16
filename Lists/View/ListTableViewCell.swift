//
//  ListTableViewCell.swift
//  Lists
//
//  Created by Mateus Reckziegel on 16/05/21.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    
    static let identifier = "ListTableViewCell"
    
    @IBOutlet var lblName: UILabel!
    @IBOutlet var lblCreationDate: UILabel!
    @IBOutlet var lblCompletion: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
