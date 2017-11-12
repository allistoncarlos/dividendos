//
//  CompanyViewController.swift
//  Dividendos
//
//  Created by Alliston Aleixo on 30/07/16.
//  Copyright © 2016 Alliston Aleixo. All rights reserved.
//

import Foundation
import UIKit

class CompanyViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    // MARK: - Outlets
    @IBOutlet weak var name:                    UILabel!
    @IBOutlet weak var document:                UILabel!
    @IBOutlet weak var companyCodes:            UILabel!
    @IBOutlet weak var site:                    UILabel!
    @IBOutlet weak var sectorialClassification: UILabel!
    @IBOutlet weak var mainActivity:            UILabel!
    @IBOutlet weak var noticesView:             UIView!
    @IBOutlet weak var noticesTableView:        UITableView!
    @IBOutlet weak var detailView:              UIView!
    @IBOutlet weak var detailEmptyView:         UIView!
    
    // MARK: - Properties
    var company: Company?;
    var companyNotices: [CompanyNotice] = [CompanyNotice]();
    
    // MARK: - Override Methods
    internal override func viewWillAppear(_ animated: Bool) {
        self.title = "Empresa";
        
        if (!DividendsProducts.hasActiveSubscription()) {
            noticesView.isHidden = true;
        }
        
        super.viewWillAppear(animated);
    }
    
    internal override func viewDidLoad() {
        super.viewDidLoad();
        
        if (company != nil) {
            self.detailView.isHidden            = false;
            self.detailEmptyView.isHidden       = true;
            
            self.navigationItem.title           = company?.name;
            
            // CompanyName Label
            self.name.numberOfLines             = 0;
            self.mainActivity.numberOfLines     = 0;
            
            self.name.text                      = company?.name;
            self.document.text                  = company?.cnpj;
            self.companyCodes.text              = company?.companyCodes;
            self.site.text                      = company?.site;
            self.sectorialClassification.text   = company?.sectorialClassification;
            self.mainActivity.text              = company?.mainActivity;
            
            // TableView
            noticesTableView.rowHeight          = UITableViewAutomaticDimension;
            noticesTableView.estimatedRowHeight = 100;
            
            self.pleaseWait();
            
            let id: Int = (company?.id)!;
            
            CompanyNoticeService.shared.getNotices(id: id,
                success: { notices in
                    self.clearAllNotice();
                    
                    self.companyNotices = notices;
                    
                    self.noticesTableView.reloadData();
                },
                failure: { error in
                    self.clearAllNotice();
                });
        }
        else {
            self.detailView.isHidden            = true;
            self.detailEmptyView.isHidden       = false;
        }
    }
    
    // MARK: - TableView Methods
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.companyNotices.count;
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noticeTableViewCell", for: indexPath) as UITableViewCell;
        
        if (self.companyNotices.count > 0) {
            let companyNotice = self.companyNotices[indexPath.item];
            
            cell.textLabel?.text = companyNotice.title;
            cell.textLabel?.lineBreakMode = .byWordWrapping;
            cell.textLabel?.numberOfLines = 0;
            
            cell.detailTextLabel?.text = "\(dateFormatter.string(from: companyNotice.date! as Date))";
        }
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        let companyNotice = self.companyNotices[indexPath.item];
        
        if (companyNotice.link != "") {
            UIApplication.shared.openURL(URL(string: companyNotice.link)!);
        }
        
        return indexPath;
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true);
    }
}
