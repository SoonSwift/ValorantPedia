//
//  ValoarntPediaTests.swift
//  ValoarntPediaTests
//
//  Created by Marcin Dytko on 07/09/2023.
//

import XCTest
@testable import ValorantPedia

final class ValoarntPediaTests: XCTestCase {

    func testGetAgents() {
        let valorantManager = ValorantManager(fetchableManager: MockFetchManager(expectedObject: AgentResult.testModel))
        
        let expectation = expectation(description: "API CALL SUCESSFUL")
        
        valorantManager.getAgents { (result: Result<AgentResult, Error>) in
            switch result {
            case .success(let success):
                XCTAssertEqual(success.data.count, 1)
                XCTAssertEqual(success.data[0].displayName, "Raze")
                expectation.fulfill()
            case .failure(let failure):
                XCTFail("FAIL API REQUEST \(failure)")
            }
        }
        waitForExpectations(timeout: 0.3)
    }
    
    func testGetGunsIsNotNil() {
        let valorantManager = ValorantManager(fetchableManager: MockFetchManager(expectedObject: GunResult.gunTestModel))
        
        let expectation = XCTestExpectation(description: "API CALL SUCCESSFUL")
        
        valorantManager.getGuns { (result: Result<GunResult, Error>) in
            switch result {
            case .success(let success):
                XCTAssertEqual(success.data.count, 1)
                XCTAssertEqual(success.data[0].displayName, "Odin")
                expectation.fulfill()
            case .failure(let failure):
                XCTFail("FAIL API REQUEST \(failure)")
            }
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testGetMapsIsNotNil() {
        let valorantManager = ValorantManager(fetchableManager: MockFetchManager(expectedObject: MapResult.mapTestModel))
        
        let expectation = XCTestExpectation(description: "API CALL SUCCESSFUL")
        
        valorantManager.getMap { (result: Result<MapResult, Error>) in
            switch result {
            case .success(let success):
                XCTAssertEqual(success.data.count, 1)
                XCTAssertEqual(success.data[0].displayName, "Ascent")
                expectation.fulfill()
            case .failure(let failure):
                XCTFail("FAIL API REQUEST \(failure)")
            }
        }
        wait(for: [expectation], timeout: 2)
    }
    
}

private class MockFetchManager: Fetchable {
    func fetchData<T>(url: String, completion: @escaping (Result<T, Error>) -> Void) where T: Decodable {
        if let expectedObject = expectedObject as? T {
            let result: Result<T, Error> = .success(expectedObject)
            completion(result)
        }
    }
    
    let expectedObject: Decodable
    
    init(expectedObject: Decodable) {
        self.expectedObject = expectedObject
    }
}
