//
//  Bootstrap.swift
//  Sileo
//
//  Created by Amy While on 15/04/2023.
//  Copyright © 2023 Sileo Team. All rights reserved.
//

import Foundation

enum Bootstrap: String, Codable {
    
    static let rootless = URL(fileURLWithPath: "/var/jb/.procursus_strapped").exists
    
    case procursus = "Procursus"
    case xina = "Procursus/Xina"
    case elucubratus = "Bingner/Elucubratus"
    case electra = "Electra/Chimera"
    case unc0ver = "Unc0verstrap"
    
    init(jailbreak: Jailbreak) {
        switch jailbreak {
        default:
            self = .procursus
        }
    }
    
}
