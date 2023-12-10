//
//  GunInfoView.swift
//  ValoarntPedia
//
//  Created by Marcin Dytko on 05/10/2023.
//

import SwiftUI

struct GunInfoView: View {
    //MARK: - PROPERTIES
    
    let gun: GunInfo
    
    // MARK: - BODY
    var body: some View {
        GroupBox {
            DisclosureGroup("Gun informations") {
                GroupBoxRowView(textHeader: "Fire rate:", textValue: gun.weaponStats?.fireRate?.dollarString ?? "")
                GroupBoxRowView(textHeader: "Magazine size:", textValue: "\(gun.weaponStats?.magazineSize ?? 1)")
                GroupBoxRowView(textHeader: "Equip time in seconds:", textValue: "\(gun.weaponStats?.equipTimeSeconds ?? 1)")
                GroupBoxRowView(textHeader: "Relode time in seconds:", textValue: "\(gun.weaponStats?.reloadTimeSeconds ?? 1)")
                GroupBoxRowView(textHeader: "Wall penetration:", textValue: gun.weaponStats?.wallPenetration?.removePrefix("EWallPenetrationDisplayType::") ?? "")
            }
        }
        
    }
}
// MARK: - PREVIEW
//#Preview {
//    GunInfoView(gun: GunInfo.previewGun)
//}
