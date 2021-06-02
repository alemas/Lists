//
//  ListItemTableViewCell.swift
//  Lists
//
//  Created by Mateus Reckziegel on 01/05/21.
//

import UIKit

class ListItemTableViewCell: UITableViewCell {
    
    static let identifier = "ListItemTableViewCell"

    @IBOutlet var lblDescription: UILabel!
    @IBOutlet var checkboxView: CheckboxView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
