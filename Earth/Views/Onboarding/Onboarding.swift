//
//  Onboarding.swift
//  Earth
//
//  Created by 이종선 on 11/15/23.
//

import Foundation

enum Onboarding: CaseIterable {
    case welcome
    case name
    case birth
    case end
    case picture
    case thanks
    
    var progress: Double {
        switch self{
        case .welcome:
            return 0.0
        case .name:
            return 0.2
        case .birth:
            return 0.4
        case .end:
            return 0.6
        case .picture:
            return 0.8
        case .thanks:
            return 1.0
        }
    }
    
    func next() -> Onboarding {
        
        guard let currentIndex = Self.allCases.firstIndex(of: self) else {
            fatalError("Current case not found in allCase ")
        }
        
        let nextIndex = Self.allCases.index(after: currentIndex)
        
        let nextCase = Self.allCases.indices.contains(nextIndex) ? Self.allCases[nextIndex] : Self.allCases.first!
        
        return nextCase
    }
}
