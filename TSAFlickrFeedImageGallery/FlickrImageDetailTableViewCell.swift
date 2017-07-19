//
//  FlickrImageDetailTableViewCell.swift
//  TSAFlickrFeedImageGallery
//
//  Created by Anil Saini on 7/19/17.
//  Copyright © 2017 Anil Saini. All rights reserved.
//

import UIKit

class FlickrImageDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
