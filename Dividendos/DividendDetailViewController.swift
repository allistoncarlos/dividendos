//
//  DividendDetailViewController.swift
//  Dividendos
//
//  Created by Alliston Aleixo on 03/10/16.
//  Copyright © 2016 Alliston Aleixo. All rights reserved.
//

import UIKit
import Foundation

class DividendDetailViewController: BaseViewController {
    // MARK: - Outlets
    @IBOutlet weak var cardView:                UIView!
    @IBOutlet weak var cardEmptyView:           UIView!
    @IBOutlet weak var companyNameLabel:        UILabel!
    @IBOutlet weak var companyCNPJLabel:        UILabel!
    @IBOutlet weak var dividendTypeLabel:       UILabel!
    @IBOutlet weak var dividendPriceLabel:      UILabel!
    @IBOutlet weak var companyCodesLabel:       UILabel!
    
    @IBOutlet weak var paymentDateLabel:        UILabel!
    @IBOutlet weak var exDateLabel:             UILabel!
    @IBOutlet weak var approvationDateLabel:    UILabel!
    
    @IBOutlet weak var fullNoticeButton:        UIBarButtonItem!
    // MARK: - Properties
    var dividend: Dividend?;
    
    // MARK: - Override Methods
    override func viewWillAppear(_ animated: Bool) {
        self.title = "Dividendo";
        
        // Set data
        if (self.dividend != nil) {
            self.fullNoticeButton.isEnabled = true;
            self.cardView.isHidden          = false;
            self.cardEmptyView.isHidden     = true;
            
            self.title                      = dividend!.companyName;
            self.companyNameLabel.text      = dividend!.companyName;
            self.companyCNPJLabel.text      = dividend!.companyCNPJ;
            self.companyCodesLabel.text     = dividend!.stockCodes;
            self.dividendTypeLabel.text     = dividend!.dividendType == .Dividends ? "DIVIDENDOS" : "JUROS SOBRE CAPITAL PRÓPRIO";
            self.dividendPriceLabel.text    = "\(dividend!.pricePerStock) por ação";
            
            if (dividend!.paymentDate != nil) {
                self.paymentDateLabel.text      = "PAGAMENTO: \(dateFormatter.string(from: dividend!.paymentDate! as Date))";
            }
            
            if (dividend!.exDate != nil) {
                self.exDateLabel.text           = "DATA EX: \(dateFormatter.string(from: dividend!.exDate! as Date))";
            }
            
            if (dividend!.approvationDate != nil) {
                self.approvationDateLabel.text  = "APROVAÇÃO: \(dateFormatter.string(from: dividend!.approvationDate! as Date))";
            }
            
            // FullNoticeURL
            if (dividend!.fullNoticeUrl == nil) {
                fullNoticeButton.isEnabled = false;
            }
            
            // CompanyName Label
            self.companyNameLabel.numberOfLines = 0;
            
            // Border
            self.cardView.alpha = 1.0;
            self.cardView.layer.masksToBounds = false;
            self.cardView.layer.shadowOffset = CGSize(width: 1.2, height: 1.2);
            self.cardView.layer.shadowRadius = 1;
            self.cardView.layer.shadowOpacity = 0.2;
            
            self.cardView.layer.borderWidth = 0.3;
            self.cardView.layer.borderColor = UIColor(red: 212/255, green: 212/255, blue: 212/255, alpha: 1).cgColor;
        }
        else {
            self.fullNoticeButton.isEnabled = false;
            self.cardView.isHidden          = true;
            self.cardEmptyView.isHidden     = false;
        }
        
        super.viewWillAppear(animated);
    }
    
    // MARK: - Actions
    @IBAction func fullNoticeTouched(_ sender: AnyObject) {
        UIApplication.shared.openURL(URL(string: dividend!.fullNoticeUrl!)!);
    }
    
}
