//
//  ValorantManager.swift
//  ValoarntPedia
//
//  Created by Marcin Dytko on 07/09/2023.
//

import Foundation
import OSLog

let logger = Logger()

class ValorantManager {
    let fetchableManager: Fetchable
    
    init(fetchableManager: Fetchable) {
        self.fetchableManager = fetchableManager
    }
    
    private func fetchData<T: Decodable>(fromURL url: String, completion: @escaping (Result<T, Error>) -> Void) {
        fetchableManager.fetchData(url: url) { (result: Result<T, Error>) in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                logger.critical("Błąd pobierania danych z API: \(error)")
                completion(.failure(error))
            }
        }
    }
   
    func getAgents(completion: @escaping (Result<AgentResult, Error>) -> Void) {
        fetchData(fromURL: "https://valorant-api.com/v1/agents?isPlayableCharacter=true", completion: completion)
    }
    
    func getMap(completion: @escaping (Result<MapResult, Error>) -> Void) {
        fetchData(fromURL: "https://valorant-api.com/v1/maps", completion: completion)
    }

    func getGuns(completion: @escaping (Result<GunResult, Error>) -> Void) {
        fetchData(fromURL: "https://valorant-api.com/v1/weapons", completion: completion)
    }
}
