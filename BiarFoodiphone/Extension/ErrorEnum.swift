//
//  ErrorEnum.swift
//  BiarFoodiphone
//
//  Created by Ecc on 20/09/2023.
//

import Foundation
enum ErrorEnum: Error,LocalizedError {
    case logFailde
    
    
    var errorDescription: String? {
        switch self {
            
        case .logFailde:
            return "E-mail oder Password is falsch, bitte versuchen sie weiter!"
        }
    }
}
