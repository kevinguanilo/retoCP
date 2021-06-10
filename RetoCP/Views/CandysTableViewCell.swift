//
//  CandysTableViewCell.swift
//  RetoCP
//
//  Created by Kevin Guanilo on 6/10/21.
//

import UIKit

class CandysTableViewCell: UITableViewCell {

    @IBOutlet weak var candyImg: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    static let identifier = String(describing: CandysTableViewCell.self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        
    }
    
    public static func buildCell() -> UINib {
        return UINib(nibName: CandysTableViewCell.identifier, bundle: nil)
    }
    
    public func setupCell(items: Items) {
        
        if let validUrl = URL(string: items.name) {
            if let data = try? Data(contentsOf: validUrl) {
                let image = UIImage(data: data)
                self.candyImg.image = image
            }
        }
        self.descriptionLabel.text = items.description
        self.priceLabel.text = items.price
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
