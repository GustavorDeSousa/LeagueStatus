//
//  MatchTableViewCell.swift
//  LeagueStatus
//
//  Created by Gustavo De Sousa on 25/08/19.
//  Copyright © 2019 Gustavo De Sousa. All rights reserved.
//

import UIKit

class MatchTableViewCell: UITableViewCell {

    @IBOutlet weak var imgChampion: UIImageView!
    @IBOutlet weak var lblChampion: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
