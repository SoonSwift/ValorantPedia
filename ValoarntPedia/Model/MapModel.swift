//
//  MapModel.swift
//  ValoarntPedia
//
//  Created by Marcin Dytko on 09/09/2023.
//

import Foundation

struct MapResult: Decodable {
    let status: Int
    let data: [MapInfo]
    
    static let mapTestModel = MapResult(status: 200, data: [
        MapInfo(displayName: "Ascent",
                narrativeDescription: "An open playground for small wars of position and attrition divide two sites on Ascent. Each site can be fortified by irreversible bomb doors; once they’re down, you’ll have to destroy them or find another way. Yield as little territory as possible.",
                tacticalDescription: "A/B Sites" ,
                coordinates: "",
                displayIcon: "https://media.valorant-api.com/maps/7eaecc1b-4337-bbf6-6ab9-04b8f06b3319/displayicon.png",
                listViewIcon: "https://media.valorant-api.com/maps/7eaecc1b-4337-bbf6-6ab9-04b8f06b3319/listviewicon.png",
                splash: "https://media.valorant-api.com/maps/7eaecc1b-4337-bbf6-6ab9-04b8f06b3319/splash.png")]
    )
}

struct MapInfo: Decodable, Identifiable {
    
    let id = UUID()
    let displayName: String
    let narrativeDescription: String?
    let tacticalDescription: String?
    let coordinates: String?
    let displayIcon: String?
    let listViewIcon: String?
    let splash: String?

    #if DEBUG
    static let previewExample = MapInfo(displayName: "Ascent",
                                        narrativeDescription: "An open playground for small wars of position and attrition divide two sites on Ascent. Each site can be fortified by irreversible bomb doors; once they’re down, you’ll have to destroy them or find another way. Yield as little territory as possible.",
                                        tacticalDescription: "A/B Sites" ,
                                        coordinates: "",
                                        displayIcon: "https://media.valorant-api.com/maps/7eaecc1b-4337-bbf6-6ab9-04b8f06b3319/displayicon.png",
                                        listViewIcon: "https://media.valorant-api.com/maps/7eaecc1b-4337-bbf6-6ab9-04b8f06b3319/listviewicon.png",
                                        splash: "https://media.valorant-api.com/maps/7eaecc1b-4337-bbf6-6ab9-04b8f06b3319/splash.png")
    #endif
}
