//
//  DividendTableVIewCell.swift
//  Dividendos
//
//  Created by Alliston Aleixo on 24/07/16.
//  Copyright © 2016 Alliston Aleixo. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore

class DividendTableViewCell : UITableViewCell {
    @IBOutlet weak var cardView: UIView!
    
    @IBOutlet weak var companyLabel: UILabel!;
    @IBOutlet weak var companyCodeLabel: UILabel!;
    @IBOutlet weak var approvationDate: UILabel!;
    @IBOutlet weak var exDate: UILabel!;
    
    @IBOutlet weak var dividendImage: UIImageView!;
    
    override func layoutSubviews() {
        super.layoutSubviews();
        
        self.cardView.alpha = 1.0;
        self.cardView.layer.masksToBounds = false;
        self.cardView.layer.shadowOffset = CGSize(width: 1.2, height: 1.2);
        self.cardView.layer.shadowRadius = 1;
        self.cardView.layer.shadowOpacity = 0.2;
        
        self.cardView.layer.borderWidth = 0.3;
        self.cardView.layer.borderColor = UIColor(red: 212/255, green: 212/255, blue: 212/255, alpha: 1).cgColor;
    }
}
