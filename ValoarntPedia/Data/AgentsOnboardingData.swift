//
//  AgentsOnboardingData.swift
//  ValoarntPedia
//
//  Created by Marcin Dytko on 07/09/2023.
//

import SwiftUI

extension AgentOnboardingScreen {
    static let data = [
        AgentOnboardingScreen(name: "Raze",
                              role: "Duelist",
                              description: "Raze explodes out of Brazil with her big personality and big guns. With her blunt-force-trauma playstyle, she excels at flushing entrenched enemies and clearing tight spaces with a generous dose of \"boom.\"",
                              photo: "Raze",
                              gradientColors: [Color("RazeLight"), Color("RazeDark")]),
        AgentOnboardingScreen(name: "Sage",
                              role: "Sentinel",
                              description: "The bastion of China, Sage creates safety for herself and her team wherever she goes. Able to revive fallen friends and stave off forceful assaults, she provides a calm center to a hellish battlefield.", 
                              photo: "Sage", gradientColors: [Color("SageLight"), Color("SageDark")]) ,
        AgentOnboardingScreen(name: "Chamber",
                              role: "Sentinel", 
                              description: "Well-dressed and well-armed, French weapons designer Chamber expels aggressors with deadly precision. He leverages his custom arsenal to hold the line and pick off enemies from afar, with a contingency built for every plan.",
                              photo: "Chamber",
                              gradientColors: [Color("ChamberLight"), Color("ChamberDark")]) ,
        AgentOnboardingScreen(name: "KAY/O",
                              role: "Initiator",
                              description: "KAY/O is a machine of war built for a single purpose: neutralizing radiants. His power to Suppress enemy abilities dismantles his opponents' capacity to fight back, securing him and his allies the ultimate edge.",
                              photo: "KAYO",
                              gradientColors: [Color("KayoLight"), Color("KayoDark")])
    ]
}
