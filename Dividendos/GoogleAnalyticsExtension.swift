//
//  GoogleAnalyticsExtension.swift
//  Dividendos
//
//  Created by Alliston Aleixo on 08/01/17.
//  Copyright © 2017 Alliston Aleixo. All rights reserved.
//

import Foundation

extension UIViewController {
    func sendScreenView() {
        let tracker = GAI.sharedInstance().defaultTracker;
//        tracker?.set(kGAIScreenName, value: self.title);
//        tracker!.send(GAIDictionaryBuilder.createScreenView()?.build() as [NSObject : AnyObject]!)
    }
    
    func trackEvent(category: String, action: String, label: String, value: NSNumber?) {
        let tracker = GAI.sharedInstance().defaultTracker
        let trackDictionary = GAIDictionaryBuilder.createEvent(withCategory: category, action: action, label: label, value: value)
        tracker?.send(trackDictionary?.build() as [NSObject : AnyObject]!)
    }
}
