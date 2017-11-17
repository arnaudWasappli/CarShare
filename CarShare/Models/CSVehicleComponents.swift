//
//  CSVehicleComponents.swift
//  CarShare
//
//  Created by Arnaud Lays on 17-11-16.
//  Copyright © 2017 Arnaud Lays. All rights reserved.
//

import Foundation

public protocol CSEnumToString: Codable {
    var displayString: String { get }
}

public enum CSFuelType: Int, CSEnumToString {
    case gaz, diesel, electric, hybrid = 4, unknown
    
    public var displayString: String {
        switch self {
        case .gaz:
            return "Essence".localized
        case .diesel:
            return "Diesel".localized
        case .electric:
            return "Électrique".localized
        case .hybrid:
            return "Hybride".localized
        default:
            return "Inconnu".localized
        }
    }
}

public enum CSGearType: Int, CSEnumToString {
    case automatic, manual
    
    public var displayString: String {
        switch self {
        case .automatic:
            return "Automatique".localized
        case .manual:
            return "Manuelle".localized
        }
    }
}

public enum CSCategory: String, CSEnumToString {
    case city          = "CITADINE"
    case compact       = "COMPACTE"
    case family        = "FAMILIALE"
    case comfort       = "CONFORT_ET_FUN"
    case electric      = "ELECTRIQUE"
    case light_utility = "UTILITAIRE_LEGER"
    case heavy_utility = "UTILITAIRE_LOURD"
    
    public var displayString: String {
        switch self {
        case .city:
            return "Citadine".localized
        case .compact:
            return "Compacte".localized
        case .family:
            return "Familiale".localized
        case .comfort:
            return "Confort / Fun".localized
        case .electric:
            return "Electrique".localized
        case .light_utility:
            return "Utilitaire léger".localized
        case .heavy_utility:
            return "Utilitaire lourd".localized
        }
    }
    
    public var iconString: String {
        return "category_\(self)".lowercased()
    }
}
