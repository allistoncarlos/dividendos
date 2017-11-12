//
//  ServiceErrorEnum.swift
//  Dividendos
//
//  Created by Alliston Aleixo on 20/09/16.
//  Copyright © 2016 Alliston Aleixo. All rights reserved.
//

import Foundation

public enum ServiceErrorEnum: String {
    case Default                        = "Default"
    case UserPasswordInvalid            = "UserPasswordInvalid"
    case UserDisabled                   = "UserDisabled"
    case UserEmptyEmail                 = "UserEmptyEmail"
    case UserNotFound                   = "UserNotFound"
    case UserEmptyFirstName             = "UserEmptyFirstName"
    case UserEmptyLastName              = "UserEmptyLastName"
    case UserAlreadyRegistered          = "UserAlreadyRegistered"
}
