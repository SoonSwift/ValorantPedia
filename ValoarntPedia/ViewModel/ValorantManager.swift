//
//  ValorantManager.swift
//  ValoarntPedia
//
//  Created by Marcin Dytko on 07/09/2023.
//

import Foundation
import OSLog

let logger = Logger()

protocol ValorantManagerPrototype {
    func getAgentsAsync() async throws -> AgentResult
    func getGunsAsync() async throws -> GunResult
    func getMapsAsync() async throws -> MapResult
}


class MockValorantManager: ValorantManagerPrototype {
    func getAgentsAsync() async throws -> AgentResult {
        AgentResult.testModel
    }
    
    func getGunsAsync() async throws -> GunResult {
        GunResult.gunTestModel
    }
    
    func getMapsAsync() async throws -> MapResult {
        MapResult.mapTestModel
    }
}

class ValorantManager: ValorantManagerPrototype {
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
    
    func getAgentsAsync() async throws -> AgentResult {
        try await fetchableManager.fetchDataAsync(url: URL(string: "https://valorant-api.com/v1/agents?isPlayableCharacter=true")!)
    }
   
    func getMap(completion: @escaping (Result<MapResult, Error>) -> Void) {
        fetchData(fromURL: "https://valorant-api.com/v1/maps", completion: completion)
    }
    
    func getMapsAsync() async throws -> MapResult {
        try await fetchableManager.fetchDataAsync(url: URL(string: "https://valorant-api.com/v1/maps")!)
    }
   
    func getGunsAsync() async throws -> GunResult {
        try await fetchableManager.fetchDataAsync(url: URL(string: "https://valorant-api.com/v1/weapons")!)
    }
}
