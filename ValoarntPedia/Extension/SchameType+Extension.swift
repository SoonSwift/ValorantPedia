//
//  SchemeType+Extension.swift
//  ValoarntPedia
//
//  Created by Marcin Dytko on 15/10/2023.
//

import SwiftUI

extension SchameType {
    var title: LocalizedStringKey {
        switch self {
        case .system:
            return "System"
        case .dark:
            return "Dark"
        case .light:
            return "Light"
        }
    }
}
