//
//  Data+Extension.swift
//  ValoarntPedia
//
//  Created by Marcin Dytko on 15/10/2023.
//

import Foundation

extension Data {
    func decode<T: Decodable>(
        dateDecodingStategy: JSONDecoder.DateDecodingStrategy = .deferredToDate,
        keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys
    ) -> T {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = dateDecodingStategy
        decoder.keyDecodingStrategy = keyDecodingStrategy
        
        guard let loaded = try? decoder.decode(T.self, from: self) else {
            fatalError("Error: Failed to decode data from bundle.")
        }
        
        return loaded
    }
}
