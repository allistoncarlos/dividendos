//
//  CompaniesViewController.swift
//  Dividendos
//
//  Created by Alliston Aleixo on 29/06/16.
//  Copyright © 2016 Alliston Aleixo. All rights reserved.
//

import Foundation
import UIKit

class CompaniesViewController : BaseTableViewController {
    // MARK: - Properties
    var allCompanies:       [Company]           = [];
    var favoriteCompanies:  [Company]           = [];
    var resultCompanies:    [Company]           = [];
    var sections:           [String: [Company]] = [String: [Company]]();
    
    // MARK: - Controls
    let segmentedCompanies                      = UISegmentedControl(items: ["Empresas", "Favoritos"]);
    
    // MARK: - Override Methods
    // Necessário por conta do splitView.preferredDisplayMode definido como .allVisible, impedindo o self.pleaseWait de aparecer enquanto viewDidLoad
    override func viewWillAppear(_ animated: Bool) {
        self.title = "Empresas";
        
        if (DividendsProducts.hasActiveSubscription()) {
            self.segmentedCompanies.selectedSegmentIndex = 0;
            self.segmentedCompanies.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged);
            self.navigationItem.titleView = segmentedCompanies;
        }
        
        self.allCompanies = [];
        
        getCompanies();
        
        super.viewWillAppear(animated);
    }
    
    // MARK: - Actions
    @IBAction func segmentChanged(_ sender: Any) {
        // Empresas
        if (segmentedCompanies.selectedSegmentIndex == 0) {
            getCompanies();
        }
        // Favoritos
        else {
            getFavoriteCompanies();
        }
    }
    
    // MARK: - Private Methods
    func getCompanies() {
        if (self.allCompanies.count > 0) {
            self.resultCompanies    = self.allCompanies;
            self.sections           = self.sectionizeCompanies(self.resultCompanies);
            self.tableView.reloadData();
        }
        else {
            self.segmentedCompanies.isEnabled = false;
            self.pleaseWait();
            
            CompanyService.shared.getCompanies(
                success: { companies in
                    self.resultCompanies    = [];
                    
                    for company in companies {
                        self.resultCompanies.append(company);
                    }
                    
                    if (self.allCompanies.count == 0) {
                        self.allCompanies = self.resultCompanies;
                    }
                    
                    self.sections = self.sectionizeCompanies(self.resultCompanies);
                    self.tableView.reloadData();
                    
                    self.segmentedCompanies.isEnabled = true;
                    self.clearAllNotice();
            },
                failure: { error in
                    super.showErrors(error);
                    
                    self.segmentedCompanies.isEnabled = true;
                    self.clearAllNotice();
            });
        }
    }
    
    func getFavoriteCompanies(){
        self.favoriteCompanies = [];
        
        if (FavoritesService.shared.favoriteCompanies.count == 0) {
            self.segmentedCompanies.selectedSegmentIndex = 0;
            
            let alert = UIAlertController(title: "Dividendos",
                                          message: "Para adicionar favoritos, deslize da direita para a esquerda na Empresa desejada e toque em Favorito",
                                          preferredStyle: .alert);
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil);
            alert.addAction(okAction);
            
            self.present(alert, animated: true, completion: nil);
        }
        else {
            for favoriteId in FavoritesService.shared.favoriteCompanies {
                self.favoriteCompanies.append(self.allCompanies.filter{ $0.id == favoriteId }.first!);
            }
            
            self.resultCompanies    = self.favoriteCompanies;
            self.sections           = self.sectionizeCompanies(self.resultCompanies);
            self.tableView.reloadData();
        }
    }
    
    func sectionizeCompanies(_ array: [Company]) -> [String: [Company]] {
        var result = [String: [Company]]();
        
        for item in array {
            let index = item.name.characters.index(item.name.startIndex, offsetBy: 1);
            let firstLetter = self.removeDiacritics(item.name.substring(to: index).uppercased());
            
            if result[firstLetter] != nil {
                result[firstLetter]!.append(item);
            } else {
                result[firstLetter] = [item];
            }
        }
        
        for (key, value) in result {
            result[key] = value.sorted(by: { (a, b) -> Bool in
                self.removeDiacritics(a.name.lowercased()) < self.removeDiacritics(b.name.lowercased());
            })
        }
        
        return result;
    }
    
    fileprivate func getSectionKeys() -> [String] {
        return sections.keys.sorted(by: { (a, b) -> Bool in
            self.removeDiacritics(a.lowercased()) < self.removeDiacritics(b.lowercased());
        })
    }
    
    fileprivate func removeDiacritics(_ text: String) -> String {
        let numerals = Array<String>(arrayLiteral: "0", "1", "2", "3", "4", "5", "6", "7", "8", "9");
        
        if (numerals.contains(text)) {
            return "#";
        }
        
        return text.folding(options: .diacriticInsensitive, locale: Locale.current);
    }
    
    fileprivate func getAbsoluteIndex(indexPath: IndexPath) -> Int {
        var totalRows = indexPath.row;
        
        for i in 0 ..< indexPath.section {
            totalRows += self.tableView.numberOfRows(inSection: i);
        }
        
        return totalRows;
    }
    
    fileprivate func updateRow(at: IndexPath) {
        self.tableView.beginUpdates();
        self.tableView.reloadRows(at: [at], with: UITableViewRowAnimation.fade);
        self.tableView.endUpdates();
    }

    // MARK: - TableView methods
    internal override func numberOfSections(in tableView: UITableView) -> Int {
        let keys = sections.keys;
        return keys.count;
    }
    
    internal func sectionIndexTitlesForTableView(_ tableView: UITableView) -> [String]? {
        return self.getSectionKeys();
    }
    
    internal func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int {
        return index;
    }
    
    internal func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // Fetch and Sort Keys
        if (self.resultCompanies.count > 0) {
            let keys = getSectionKeys();
            
            return keys[section];
        }
        
        return "";
    }
    
    internal override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Fetch Companies
        if (self.resultCompanies.count > 0) {
            let key = self.getSectionKeys()[section]
            
            if let companies = sections[key] {
                return companies.count;
            }
        }
        
        return 0;
        
    }
    
    internal override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier: String = "companyTableViewCell";
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier);
        
        // Fetch and Sort Keys
        let keys = sections.keys.sorted(by: { (a, b) -> Bool in
            self.removeDiacritics(a.lowercased()) < self.removeDiacritics(b.lowercased());
        })
        
        // Fetch Fruits for Section
        let key = keys[(indexPath as NSIndexPath).section];
        
        if let companies = sections[key] {
            // Fetch Companies
            let company = companies[(indexPath as NSIndexPath).row];
            
            // Configure Cell
            if (FavoritesService.shared.favoriteCompanies.contains(company.id)) {
                cell?.accessoryView = UIImageView(image: UIImage(named: "Favorites"));
            }
            else {
                cell?.accessoryView = nil;
            }
            
            cell?.textLabel?.text = company.name;
            cell?.detailTextLabel?.text = company.cnpj;
            cell?.detailTextLabel?.textColor = UIColor(red: 143/255, green: 142/255, blue: 148/255, alpha: 1);
        }
        
        return cell!;
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50;
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let company = self.resultCompanies[self.getAbsoluteIndex(indexPath: indexPath)] as Company;
        
        if (!FavoritesService.shared.favoriteCompanies.contains(company.id)) {
            let favorite = UITableViewRowAction(style: .normal, title: "Favorito") { action, index in
                self.segmentedCompanies.isEnabled = false;
                self.pleaseWait();
                
                tableView.setEditing(false, animated: true);
                
                FavoritesService.shared.save(companyId: company.id, completionHandler: { (error) in
                    if (error == nil) {
                        // Mostrar que é um favorito
                        DispatchQueue.main.async {
                            self.updateRow(at: indexPath);
                        }
                    }
                    
                    self.segmentedCompanies.isEnabled = true;
                    self.clearAllNotice();
                });
            }
            
            favorite.backgroundColor = UIColor.orange;
            
            return [favorite];
        }
        else {
            let remove = UITableViewRowAction(style: .normal, title: "Remover") { action, index in
                self.segmentedCompanies.isEnabled = false;
                self.pleaseWait();
                
                tableView.setEditing(false, animated: true);
                
                FavoritesService.shared.delete(companyId: company.id, completionHandler: { (error) in
                    if (error == nil) {
                        // Mostrar que não é um favorito
                        DispatchQueue.main.async {
                            self.updateRow(at: indexPath);
                        }
                    }
                    
                    self.segmentedCompanies.isEnabled = true;
                    self.clearAllNotice();
                });
            }
            
            remove.backgroundColor = UIColor.red;
            
            return [remove];
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return DividendsProducts.hasActiveSubscription();
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "companyDetailSegue"){
            let destination                                             = (segue.destination as! UINavigationController).topViewController as! CompanyViewController;
            let indexPath                                               = tableView.indexPathForSelectedRow! as IndexPath;
            let company                                                 = self.resultCompanies[self.getAbsoluteIndex(indexPath: indexPath)] as Company;
            destination.company                                         = company;
            destination.navigationItem.leftBarButtonItem                = self.splitViewController?.displayModeButtonItem;
            destination.navigationItem.leftItemsSupplementBackButton    = true;
        }
    }
}
