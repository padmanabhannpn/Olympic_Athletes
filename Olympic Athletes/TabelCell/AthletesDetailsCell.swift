//
//  AthletesDetailsCell.swift
//  Olympic Athletes
//
//  Created by PADMANABHAN on 11/09/23.
//

import Foundation
import UIKit

class AthletesDetailsCell: UITableViewCell {

    @IBOutlet weak var UserImage: UIImageView!
    @IBOutlet weak var NameLbl: UILabel!
    @IBOutlet weak var DOBLbl: UILabel!
    @IBOutlet weak var WeigthLbl: UILabel!
    @IBOutlet weak var HeigthLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
