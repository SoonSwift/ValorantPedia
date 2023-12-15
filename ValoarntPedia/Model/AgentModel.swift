//
//  AgentModel.swift
//  ValoarntPedia
//
//  Created by Marcin Dytko on 07/09/2023.
//

import SwiftUI

struct AgentResult: Decodable, Equatable {
    let status: Int
    let data: [AgentInfo]
    
    #if DEBUG
     static let testModel = AgentResult(
        status: 200,
        data: [
            AgentInfo(
                displayName: "Raze", 
                description: "Raze explodes",
                displayIcon: "https://media.valorant-api.com/agents/f94c3b30-42be-e959-889c-5aa313dba261/displayicon.png",
                fullPortrait: "https://media.valorant-api.com/agents/f94c3b30-42be-e959-889c-5aa313dba261/fullportrait.png",
                background: "https://media.valorant-api.com/agents/f94c3b30-42be-e959-889c-5aa313dba261/background.png",
                backgroundGradientColors: ["feac45ff", "d64f35ff"],
                abilities: [
                    Ability(
                        displayName: "Blast Pack",
                        description: "INSTANTLY throw a Blast Pack that will stick to surfaces. RE-USE the ability after deployment to detonate, damaging and moving anything hit.",
                        displayIcon: "https://media.valorant-api.com/agents/f94c3b30-42be-e959-889c-5aa313dba261/abilities/ability1/displayicon.png"),
                    Ability(displayName: "Paint Shells",
                            description: "EQUIP a cluster grenade. FIRE to throw the grenade, which does damage and creates sub-munitions, each doing damage to anyone in their range. ALT FIRE to lob. Paint Shells charge resets every two kills.",
                            displayIcon: "https://media.valorant-api.com/agents/f94c3b30-42be-e959-889c-5aa313dba261/abilities/ability2/displayicon.png")
                ],
                role:
                    RoleInfo(
                        displayName: "Duelist",
                        description: "Duelists are self-sufficient fraggers who their team expects, through abilities and skills, to get high frags and seek out engagements first.",
                        displayIcon: "https://media.valorant-api.com/agents/roles/dbe8757e-9e92-4ed4-b39f-9dfc589691d4/displayicon.png")
            )
        ]
     )
    #endif
}

struct AgentInfo: Decodable, Identifiable, Equatable {
    let id = UUID()
    let displayName: String
    let description: String
    let displayIcon: String
    let fullPortrait: String
    let background: String
    let backgroundGradientColors: [String]
    let abilities: [Ability]
    let role: RoleInfo
    
    #if DEBUG
    static let agentPreview = AgentInfo(
        displayName: "Raze",
        description: "Raze explodes out of Brazil with her big personality and big guns. With her blunt-force-trauma playstyle, she excels at flushing entrenched enemies and clearing tight spaces with a generous dose of \"boom.\"",
        displayIcon: "https://media.valorant-api.com/agents/f94c3b30-42be-e959-889c-5aa313dba261/displayicon.png",
        fullPortrait: "https://media.valorant-api.com/agents/f94c3b30-42be-e959-889c-5aa313dba261/fullportrait.png",
        background: "https://media.valorant-api.com/agents/f94c3b30-42be-e959-889c-5aa313dba261/background.png",
        backgroundGradientColors: ["feac45ff", "d64f35ff"],
        abilities: [
            Ability(
                displayName: "Blast Pack",
                description: "INSTANTLY throw a Blast Pack that will stick to surfaces. RE-USE the ability after deployment to detonate, damaging and moving anything hit.",
                displayIcon: "https://media.valorant-api.com/agents/f94c3b30-42be-e959-889c-5aa313dba261/abilities/ability1/displayicon.png"
            ),
            Ability(
                displayName: "Paint Shells",
                description: "EQUIP a cluster grenade. FIRE to throw the grenade, which does damage and creates sub-munitions, each doing damage to anyone in their range. ALT FIRE to lob. Paint Shells charge resets every two kills.",
                displayIcon: "https://media.valorant-api.com/agents/f94c3b30-42be-e959-889c-5aa313dba261/abilities/ability2/displayicon.png")],
        role:
            RoleInfo(
                displayName: "Duelist",
                description: "Duelists are self-sufficient fraggers who their team expects, through abilities and skills, to get high frags and seek out engagements first.",
                displayIcon: "https://media.valorant-api.com/agents/roles/dbe8757e-9e92-4ed4-b39f-9dfc589691d4/displayicon.png")
    )
    #endif
}

struct AgentOnboardingScreen: Hashable {
    let name: String
    let role: String
    let description: String
    let photo: String
    let gradientColors: [Color]
}

struct Ability: Decodable, Identifiable, Equatable {
    let id = UUID()
    let displayName: String
    let description: String
    let displayIcon: String?
}

struct RoleInfo: Decodable, Equatable {
    let displayName: String
    let description: String
    let displayIcon: String
}
