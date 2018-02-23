//
//  SampleTableViewCell.swift
//  RxSwiftSampleApp
//
//  Created by Durgesh Pandey on 08/11/17.
//  Copyright © 2017 Durgesh Pandey. All rights reserved.
//

import UIKit

class SampleTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
