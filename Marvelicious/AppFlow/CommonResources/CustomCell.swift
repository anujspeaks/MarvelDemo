//
//  CustomCell.swift
//  Marvelicious
//
//  Created by ANUJ NIGAM on 13/06/18.
//  Copyright © 2018 ANUJ NIGAM. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var imgItem: UIImageView!
    @IBOutlet weak var lblItem: UILabel!
    @IBOutlet weak var spinnerItem: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
class CustomDetailCell: UITableViewCell {
    
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var imgItem: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblSeriesComics: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
