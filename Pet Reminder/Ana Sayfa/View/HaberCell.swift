//
//  HaberCell.swift
//  Pet Reminder
//
//  Created by Ahmet Erkut on 24.05.2023.
//

import UIKit

class HaberCell: UITableViewCell {

    @IBOutlet weak var baslikLabel: UILabel!
    @IBOutlet weak var icerikLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
