//
//  AccountViewController.swift
//  Dividendos
//
//  Created by Alliston Aleixo on 28/07/16.
//  Copyright © 2016 Alliston Aleixo. All rights reserved.
//

import Foundation
import UIKit
import StoreKit

class AccountViewController : BaseTableViewController {
    // MARK: - Properties
    var products = [SKProduct]();
    var sections = ["Compra Única", "Assinaturas"];
    
    // MARK: - Override Methods
    override func viewWillAppear(_ animated: Bool) {
        self.title = "Extras";
        
        super.viewWillAppear(animated);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        // InAppPurchases        
        let restoreButton = UIBarButtonItem(title: "Restaurar",
                                            style: .plain,
                                            target: self,
                                            action: #selector(restoreInAppPurchases(sender:)));
        
        navigationItem.rightBarButtonItem = restoreButton;
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(AccountViewController.handlePurchaseNotification(_:)),
                                               name: NSNotification.Name(rawValue: InAppPurchasesHelper.IAPHelperPurchaseNotification),
                                               object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        
        reload();
    }
    
    // MARK: - In-App Purchases Methods
    func restoreInAppPurchases(sender: UIBarButtonItem) {
        DividendsProducts.store.restorePurchases();
    }
    
    func handlePurchaseNotification(_ notification: Notification) {
        guard let productID = notification.object as? String else { return }
        
        for (index, product) in products.enumerated() {
            guard product.productIdentifier == productID else { continue }
            
            let resultSection   = productID == DividendsProducts.PushNotifications ? 0 : 1;
            let resultIndex     = productID == DividendsProducts.PushNotifications ? 0 : index - 1;
            
            tableView.reloadRows(at: [IndexPath(row: resultIndex, section: resultSection)], with: .fade)
        }
    }
    
    func reload() {
        self.products = [];
        
        self.pleaseWait();
        
        tableView.reloadData();
        
        DividendsProducts.store.requestProducts{success, products in
            if (success) {
                self.products = products!;
        
                self.tableView.reloadData();
            }
        
            self.clearAllNotice();
        }
    }
    
    // MARK: - TableView methods
    internal override func numberOfSections(in tableView: UITableView) -> Int {
        return 2;
    }
    
    internal func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section];
    }
    
    
    internal override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0){
            return 1;
        }
        else {
            return self.products.count - 1;
        }
    }
    
    internal override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width;
        
        switch screenWidth {
            // iPhone 5/5S/SE Vertical
            case 320:
                return 95;
            // iPhone 6/6S/7 Vertical
            case 375:
                return 75;
            // iPhone 6+/6S+/7+ Vertical
            case 414:
                return 70
            default:
                return 65
        }
    }
    
    internal override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reusableIdentifier = "InAppPurchaseCell";
        var cell = tableView.dequeueReusableCell(withIdentifier: reusableIdentifier) as? InAppPurchaseCell;
        
        if (cell == nil)
        {
            tableView.register(UINib(nibName: reusableIdentifier, bundle: nil), forCellReuseIdentifier: reusableIdentifier)
            cell = tableView.dequeueReusableCell(withIdentifier: reusableIdentifier) as? InAppPurchaseCell
        }
        
        if (products.count > 0) {
            var product: SKProduct;
            
            if (indexPath.section == 0) {
                product = products[products.count - 1];
            }
            else {
                product = products[(indexPath as NSIndexPath).row];
            }
            
            cell?.product = product;

            cell?.buyButtonHandler = { product in
                let resultUser = SessionManager.shared.icloudUser != nil ? SessionManager.shared.icloudUser : "";
                
                self.trackEvent(category: "InAppPurchases", action: "Comprado", label: resultUser!, value: nil);
                DividendsProducts.store.buyProduct(product);
            }
        }
        
        return cell!;
    }
}
