//
//  GunModel.swift
//  ValoarntPedia
//
//  Created by Marcin Dytko on 29/09/2023.
//

import Foundation

struct GunResult: Decodable {
    let status: Int
    let data: [GunInfo]
    
    static let gunTestModel = GunResult(status: 200, data: [
        GunInfo(
            displayName: "Odin",
            displayIcon: "https://media.valorant-api.com/weapons/63e6c2b6-4a8e-869c-3d4c-e38355226584/displayicon.png",
            category: "EEquippableCategory::Heavy",
            weaponStats: WeaponStats(fireRate: 2.0, magazineSize: 100, runSpeedMultiplier: 1.76, equipTimeSeconds: 7.2, reloadTimeSeconds: 2.6, wallPenetration: "EWallPenetrationDisplayType::High"),
            shopData: ShopData(cost: 3000, category: "Heavy"),
            skins: [
                SkinData(displayName: "Altitude Odin",
                         displayIcon: "https://media.valorant-api.com/weaponskins/89be9866-4807-6235-2a95-499cd23828df/displayicon.png")
            ]
        )
    ]
    )
}

struct GunInfo: Decodable, Identifiable {
    let id = UUID()
    let displayName: String?
    let displayIcon: String?
    let category: String?
    let weaponStats: WeaponStats?
    let shopData: ShopData?
    let skins: [SkinData]
    
    #if DEBUG
    static let previewGun = GunInfo(
        displayName: "Odin",
        displayIcon: "https://media.valorant-api.com/weapons/63e6c2b6-4a8e-869c-3d4c-e38355226584/displayicon.png",
        category: "EEquippableCategory::Heavy", 
        weaponStats: WeaponStats(fireRate: 2.0, magazineSize: 100, runSpeedMultiplier: 1.76, equipTimeSeconds: 7.2, reloadTimeSeconds: 2.6, wallPenetration: "EWallPenetrationDisplayType::High"),
        shopData: ShopData(cost: 3000, category: "Heavy"),
        skins: [
            SkinData(displayName: "Altitude Odin",
                     displayIcon: "https://media.valorant-api.com/weaponskins/89be9866-4807-6235-2a95-499cd23828df/displayicon.png")
        ]
    )
    #endif
}

struct WeaponStats: Decodable {
    let fireRate: Double?
    let magazineSize: Int?
    let runSpeedMultiplier: Double?
    let equipTimeSeconds: Double?
    let reloadTimeSeconds: Double?
    let wallPenetration: String?
}

struct ShopData: Decodable {
    let cost: Int?
    let category: String?
}

struct SkinData: Decodable, Identifiable {
    let id = UUID()
    let displayName: String?
    let displayIcon: String?
}
