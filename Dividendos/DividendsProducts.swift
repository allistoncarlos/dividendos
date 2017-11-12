//
//  DividendsProducts.swift
//  Dividendos
//
//  Created by Alliston Aleixo on 12/10/16.
//  Copyright © 2016 Alliston Aleixo. All rights reserved.
//

import Foundation

public struct DividendsProducts {

    public static let PushNotifications         = "notifications";
    public static let TrimestralSubscription    = "assinaturatrimestral";
    public static let SemestralSubscription     = "assinaturasemestral";
    public static let AnualSubscription         = "assinaturaanual";
    
    fileprivate static let productIdentifiers: Set<ProductIdentifier> = [
        DividendsProducts.TrimestralSubscription,
        DividendsProducts.SemestralSubscription,
        DividendsProducts.AnualSubscription,
        DividendsProducts.PushNotifications
    ];
    
    public static let store = InAppPurchasesHelper(productIds: DividendsProducts.productIdentifiers)
    
    public static func canReceiveNotifications() -> Bool {
        return DividendsProducts.store.isProductPurchased(DividendsProducts.PushNotifications) ||
            hasActiveSubscription();
    }
    
    public static func hasActiveSubscription() -> Bool {
        return DividendsProducts.store.isProductPurchased(DividendsProducts.AnualSubscription) ||
            DividendsProducts.store.isProductPurchased(DividendsProducts.SemestralSubscription) ||
            DividendsProducts.store.isProductPurchased(DividendsProducts.TrimestralSubscription);
    }
}

func resourceNameForProductIdentifier(_ productIdentifier: String) -> String? {
    return productIdentifier.components(separatedBy: ".").last
}
