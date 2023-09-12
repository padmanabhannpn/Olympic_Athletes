//
//  AthletesMedalsCell.swift
//  Olympic Athletes
//
//  Created by PADMANABHAN on 11/09/23.
//

import Foundation
import UIKit

class AthletesMedalsCell: UITableViewCell {


    @IBOutlet weak var PlaceName: UILabel!
    @IBOutlet weak var GoldCound: UILabel!
    @IBOutlet weak var SliverCount: UILabel!
    @IBOutlet weak var BronzeCount: UILabel!
    
    @IBOutlet weak var GoldImage: UIImageView!
    @IBOutlet weak var SliverImage: UIImageView!
    @IBOutlet weak var BronzeImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
