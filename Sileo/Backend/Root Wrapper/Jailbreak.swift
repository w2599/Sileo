//
//  File.swift
//  Sileo
//
//  Created by Amy While on 15/04/2023.
//  Copyright © 2023 Sileo Team. All rights reserved.
//

import Foundation
import MachO

enum Jailbreak: String, Codable {
    
    static let current = Jailbreak()
    static let bootstrap = Bootstrap(jailbreak: current)
    
    // Xina
    case xina15 = "XinaA15 (iOS 15)"
    case xina15_legacy =     "XinaA15 • Legacy"
    
    // Dopamine
    case dopamine = "Dopamine (iOS 15)"

    case other = "Other"
      
    // Supported for userspace reboots
    static private let supported: Set<Jailbreak> = [ .xina15, .dopamine ]
    
    public var supportsUserspaceReboot: Bool {
        Self.supported.contains(self)
    }
    
    private init() {
        self = .other
        
        let fileManager = FileManager.default
        
        let xina15 = "/var/jb/.installed_xina15"
        if fileManager.fileExists(atPath: xina15) {
            self = .xina15
        }
	
        let dopamine = "/var/jb/.installed_dopamine"
        if fileManager.fileExists(atPath: dopamine) {
            self = .dopamine
        }
    }    
}
