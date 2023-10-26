//
//  ViewModel.swift
//  ValoarntPedia
//
//  Created by Marcin Dytko on 07/09/2023.
//

import Foundation
import OSLog

class ViewModel: ObservableObject {
    // MARK: - MANAGER
    private let valorantManger = ValorantManager(fetchableManager: Bundle.main)
    
    // MARK: - PROPERITES
    @Published var agents: AgentResult?
    @Published var maps: MapResult?
    @Published var guns: GunResult?
    
    
    private enum Property {
        case agents
        case maps
        case guns
    }
    
    // MARK: - METHODS
    private func handleResult<T>(_ result: Result<T, Error>?, for property: Property) {
        guard let result = result else { return }
        DispatchQueue.main.async {
            switch result {
            case .success(let data):
                switch property {
                case .agents:
                    self.agents = data as? AgentResult
                case .maps:
                    self.maps = data as? MapResult
                case .guns:
                    self.guns = data as? GunResult
                }
            case .failure(let error):
                logger.critical("API FAILED TO LOAD: \(error)")
            }
        }
    }
    
    func fetchAgenets() {
        valorantManger.getAgents { [weak self] result in
            self?.handleResult(result, for: .agents)
        }
    }
    
    func fetchMaps() {
        valorantManger.getMap { [weak self] result in
            self?.handleResult(result, for: .maps)
        }
    }
    
    func fetchGuns() {
        valorantManger.getGuns { [weak self] result in
            self?.handleResult(result, for: .guns)
        }
    }
}
