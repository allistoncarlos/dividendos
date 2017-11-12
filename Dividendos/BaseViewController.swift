//
//  BaseViewController.swift
//  Dividendos
//
//  Created by Alliston Aleixo on 29/06/16.
//  Copyright © 2016 Alliston Aleixo. All rights reserved.
//

import UIKit

public class BaseViewController: UIViewController {
    // MARK: - Properties
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    let dateFormatter = DateFormatter();
    
    // MARK: Custom Methods
    public func showErrors(_ errors: Array<ServiceError>) {
        var resultMessage: String = "";
        
        for error in errors {
            resultMessage.append("* \(ServiceError.getMessageError(error.description))\r\n");
        }
        
        let lastIndex = resultMessage.range(of: "\r\n", options: .backwards)?.lowerBound;
        
        let alert = UIAlertController(title: "Atenção", message: resultMessage.substring(to: lastIndex!), preferredStyle: UIAlertControllerStyle.alert);
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil));
        self.present(alert, animated: true, completion: nil);
    }
    
    // MARK: - View Methods
    public override func viewDidLoad() {
        super.viewDidLoad();
        
        UIApplication.shared.applicationIconBadgeNumber = 0;
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        // Formatter
        self.dateFormatter.locale = Locale(identifier: "pt_BR");
        self.dateFormatter.dateStyle = .short;
        
        // Google Analytics
        self.sendScreenView();
        
        super.viewWillAppear(animated);
    }
}
