//
//  FirstScreenSnapshotTests.swift
//  ValoarntPediaTests
//
//  Created by Marcin Dytko on 12/10/2023.
//

import XCTest
@testable import ValorantPedia
import SnapshotTesting
import SwiftUI

final class FirstScreenSnapshotTests: XCTestCase {

    func testSnapshotShuldInInitailState() {
        let onBoardingView = OnboardingView()
        let onBoardingViewController = UIHostingController(rootView: onBoardingView)
        
        assertSnapshot(of: onBoardingViewController, as: .image(on: .iPhone13))
    }
    
    func testSnapshotMainView() {
        let mainView = MainView().environmentObject(ViewModel())
        let mainViewController = UIHostingController(rootView: mainView)
        
        assertSnapshot(of: mainViewController, as: .image(on: .iPhone13))
    }
    
    func testSettingsView() {
        let settingsViewController = SettingsView().toVC
        
        assertSnapshot(of: settingsViewController(), as: .image(on: .iPhone13))
    }

}

extension SwiftUI.View {
    func toVC() -> UIViewController {
        let vc = UIHostingController(rootView: self)
        vc.view.frame = UIScreen.main.bounds
        return vc
    }
}
