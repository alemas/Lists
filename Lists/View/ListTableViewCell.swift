//
//  ListTableViewCell.swift
//  Lists
//
//  Created by Mateus Reckziegel on 16/05/21.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    
    static let identifier = "ListTableViewCell"
    private lazy var imvMore: UIImageView? = {
        let moreImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height:25))
        moreImageView.image = UIImage(named: "icon_more.png")?.withTintColor(UIColor.systemTeal)
        return moreImageView
    }()
    
    @IBOutlet var lblName: UILabel!
    @IBOutlet var lblCreationDate: UILabel!
    @IBOutlet var lblCompletion: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.editingAccessoryView = imvMore
        self.editingAccessoryView!.isUserInteractionEnabled = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
