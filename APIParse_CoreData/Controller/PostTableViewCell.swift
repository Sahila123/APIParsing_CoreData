//
//  PostTableViewCell.swift
//  APIParse_CoreData
//
//  Created by Mirajkar on 04/06/21.
//  Copyright © 2021 Mirajkar. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    //MARK: Global variables

    @IBOutlet weak var nameLabel : UILabel!
    @IBOutlet weak var emailLabel : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
