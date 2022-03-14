//
//  ShiftsTests.swift
//  ShiftsTests
//
//  Created by Jesus Cueto on 3/11/22.
//

import XCTest
@testable import Shifts

class StorageTests: XCTestCase {
    
    var storageManager: SHStorageManager?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.storageManager = SHLocalJSONStorage()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.storageManager = nil
    }

    func testPeopleRetrieve() throws {
        let expectation = XCTestExpectation(description: "Test People json retrieval")
        var expectedResult: PersonList = PersonList(info: [])
        self.storageManager?.retrieve(from: "People", completion: { (result: Result<PersonList, Error>) in
            switch result {
            case .success(let model):
                expectedResult = model
                expectation.fulfill()
            case .failure(_ ):
                XCTFail("Should not recieved an error")
            }
        })
        wait(for: [expectation], timeout: 1)
        XCTAssert(!expectedResult.info.isEmpty)
    }
    
    func testShiftRetrieve() throws {
        let expectation = XCTestExpectation(description: "Test Shifts json retrieval")
        var expectedResult: ShiftListModel = ShiftListModel(info: [])
        self.storageManager?.retrieve(from: "Shifts", completion: { (result: Result<ShiftListModel, Error>) in
            switch result {
            case .success(let model):
                expectedResult = model
                expectation.fulfill()
            case .failure(_ ):
                XCTFail("Should not recieved an error")
            }
        })
        wait(for: [expectation], timeout: 1)
        XCTAssert(!expectedResult.info.isEmpty)
    }
    
    func testFailureRetrieval() throws {
        let expectation = XCTestExpectation(description: "Test json failure retrieval")
        var expectedError: SHError?
        self.storageManager?.retrieve(from: "empty", completion: { (result: Result<ShiftListModel, Error>) in
            switch result {
            case .success(_ ):
                XCTFail("Should not recieved a value")
            case .failure(let error):
                expectedError = SHError(from: 0, description: error.localizedDescription)
                expectation.fulfill()
            }
        })
        wait(for: [expectation], timeout: 1)
        XCTAssertNotNil(expectedError)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
