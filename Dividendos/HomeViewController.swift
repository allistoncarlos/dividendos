//
//  FirstViewController.swift
//  Dividendos
//
//  Created by Alliston Aleixo on 28/06/16.
//  Copyright © 2016 Alliston Aleixo. All rights reserved.
//

import UIKit
import CloudKit

class HomeViewController: BaseTableViewController {
    // MARK: - Properties
    var dividends:          Array<Dividend>     = [];
    var selectedDividend:   Dividend?           = nil;
    
    // MARK: - Override Methods
    override func viewWillAppear(_ animated: Bool) {
        self.title = "Dividendos";
        
        super.viewWillAppear(animated);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        getDividends();
        
        // Se o usuário tiver assinatura ativa
        if (DividendsProducts.hasActiveSubscription()) {
            FavoritesService.shared.get();
        }
    }
    
    // MARK: - Private Methods
    func getDividends() {
        self.pleaseWait();
        
        DividendService.shared.getDividends(
            success: { dividends in
                self.dividends = [];
            
                for dividend in dividends {
                    self.dividends.append(dividend);
                }
            
                self.tableView.reloadData();
                
                self.clearAllNotice();
            },
            failure: { error in
                super.showErrors(error);
                
                self.clearAllNotice();
            }
        );
    }
    
    // MARK: - TableView methods
    internal override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dividends.count;
    }
    
    internal override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier: String = "dividendTableViewCell";
        
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? DividendTableViewCell;
        
        if (cell == nil)
        {
            tableView.register(UINib(nibName: "DividendTableViewCell", bundle: nil), forCellReuseIdentifier: identifier)
            cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? DividendTableViewCell
        }
        
        let dividend = dividends[(indexPath as NSIndexPath).row] as Dividend;
        
        cell!.companyLabel?.text = dividend.companyName as String;
        cell!.companyCodeLabel?.text = dividend.stockCodes;
        
        if (dividend.approvationDate != nil) {
            cell?.approvationDate.text = "Aprovação: \(dateFormatter.string(from: dividend.approvationDate! as Date))";
        }
        
        if (dividend.exDate != nil) {
            cell?.exDate.text = "Data Ex: \(dateFormatter.string(from: dividend.exDate! as Date))";
        }

        switch dividend.dividendType {
            case .Interests:
                cell?.dividendImage.image = UIImage(named: "Interest");
            case .Dividends:
                cell?.dividendImage.image = UIImage(named:"Dividend");
        }
        
        return cell!;
    }
    
    internal override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: false);
        
        selectedDividend = dividends[indexPath.row] as Dividend;
        
        self.performSegue(withIdentifier: "dividendDetailSegue", sender: self);
    }
    
    internal override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "dividendDetailSegue"){
            let destination                                             = (segue.destination as! UINavigationController).topViewController as! DividendDetailViewController;
            let dividend                                                = selectedDividend;
            destination.dividend                                        = dividend;
            destination.navigationItem.leftBarButtonItem                = self.splitViewController?.displayModeButtonItem;
            destination.navigationItem.leftItemsSupplementBackButton    = true;
        }
    }
}
