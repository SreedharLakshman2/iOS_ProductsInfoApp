//
//  ProductTableViewCell.swift
//  ProductsInfoApp
//
//  Created by Sreedhar L on 17/09/22.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    //MARK: - IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var categoryInfoLabel: UILabel!
    @IBOutlet weak var ratingInfoLabel: UILabel!
    @IBOutlet weak var priceInfoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    //UIImage(named: "fill_star")!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
