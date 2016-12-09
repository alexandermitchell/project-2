//
//  FeedTableViewCell.swift
//  Project-2-Mitchell
//
//  Created by Alex Mitchell on 2016-12-07.
//  Copyright © 2016 Alex Mitchell. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var publishedAtLabel: UILabel!
    
    @IBOutlet weak var articleImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.prepareForReuse()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.titleLabel.text = ""
        self.publishedAtLabel.text = ""
        self.articleImage.image = nil
    }

}
