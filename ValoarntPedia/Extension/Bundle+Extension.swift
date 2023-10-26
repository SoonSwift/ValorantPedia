//
//  Bundle+Extension.swift
//  ValoarntPedia
//
//  Created by Marcin Dytko on 07/09/2023.
//

import Foundation

protocol Fetchable {
    func fetchData<T: Decodable>(url: String, completion: @escaping (Result<T, Error>) -> Void)
}

extension Bundle: Fetchable {
    
    func fetchData<T: Decodable>(url: String, completion: @escaping (Result<T, Error>) -> Void) {
        // Build an URL
        guard let url = URL(string: url) else {
            let error = URLError(.badURL)
            completion(.failure(error))
            return
        }
        // Perform the network request
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                let error = URLError(.badServerResponse)
                completion(.failure(error))
                return
            }

            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}

enum BundleKey: String {
    case displayName = "CFBundleName"
    case appBuild = "CFBundleVersion"
    case appVersion = "CFBundleShortVersionString"
}

extension Bundle {
    func getValue(forKey key: BundleKey) -> String {
        object(forInfoDictionaryKey: key.rawValue) as? String ?? "Could not determine the application version"
    }
    
    func getData(from fileName: String) -> Data? {
        guard let url = url(forResource: fileName, withExtension: nil) else {
            fatalError("Error: Failed to locate \(fileName) in bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Error: Failed to load \(fileName) from bundle.")
        }
        
        return data
    }
}
