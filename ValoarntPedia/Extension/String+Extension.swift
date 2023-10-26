//
//  String+Extension.swift
//  ValoarntPedia
//
//  Created by Marcin Dytko on 05/10/2023.
//

import Foundation

extension String {
    func removePrefix(_ prefix: String) -> String {
        if self.hasPrefix(prefix) {
            return String(self.dropFirst(prefix.count))
        } else {
            return self
        }
    }
}
