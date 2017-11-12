//
//  ServiceResult.swift
//  Dividendos
//
//  Created by Alliston Aleixo on 19/09/16.
//  Copyright © 2016 Alliston Aleixo. All rights reserved.
//

import Foundation

public class ServiceError {
    var errorCode:      Int = 0;
    var description:    ServiceErrorEnum = .Default;
    
    init () { }
    
    init(dictionary: NSDictionary) {
        errorCode   = dictionary["ErrorCode"]   as! Int;
        description = ServiceErrorEnum(rawValue: dictionary["Description"] as! String)!;
    }
    
    static func getMessageError(_ serviceError: ServiceErrorEnum) -> String {
        switch serviceError {
            case .UserPasswordInvalid:
                return "Senha inválida";
            case .UserDisabled:
                return "Este usuário foi desativado";
            case .UserEmptyEmail:
                return "Obrigatório informar o e-mail";
            case .UserNotFound:
                return "Usuário não encontrado para este e-mail";
            case .UserEmptyFirstName:
                return "Obrigatório informar o primeiro nome";
            case .UserEmptyLastName:
                return "Obrigatório informar o último nome";
            case .UserAlreadyRegistered:
                return "Usuário já registrado anteriormente";
            
            case .Default:
                return "Houve um erro no retorno dos dados. Tente novamente mais tarde";
        }
    }
}
