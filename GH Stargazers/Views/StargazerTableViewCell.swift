//
//  StargazerTableViewCell.swift
//  GH Stargazers
//
//  Created by Emanuel Carnevale on 11/10/2020.
//

import UIKit
import SDWebImage

class StargazerTableViewCell: UITableViewCell {
    
    @IBOutlet var avatarImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!

    func setup(with stargazer: Stargazer) {
        nameLabel.text = stargazer.login
        avatarImageView.sd_setImage(with: stargazer.avatarURL)
    }

}
