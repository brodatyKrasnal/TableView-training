//
//  by: Tymek (iTmi) on: 20/05/2022 | ReusableCell.swift : TableView training 
// Copyright (c) 2022, all rights reserved. UIID: 66FA7F3A-83A8-44BD-91AB-F682819037D6 

import UIKit

class ReusableCell: UITableViewCell {

    @IBOutlet weak var descriptionLablel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var taskCompletionImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
