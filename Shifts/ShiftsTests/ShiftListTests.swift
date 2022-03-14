//
//  ShiftListTests.swift
//  ShiftsTests
//
//  Created by Jesus Cueto on 3/14/22.
//

import XCTest
@testable import Shifts

class ShiftListTests: XCTestCase {
    
    var storageManager: SHStorageManager?
    var shiftLisInteractor: SHShiftsListUseCase?
    var shiftListRepository: SHShiftListRepositoryProtocol?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.storageManager = SHLocalJSONStorage()
        self.shiftListRepository = SHShiftListRepository(from: storageManager!)
        self.shiftLisInteractor = SHShiftListInteractor(from: shiftListRepository!)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.storageManager = nil
        self.shiftListRepository = nil
        self.shiftLisInteractor = nil
    }

    func testShifListData() throws {
        let expectation = XCTestExpectation(description: "Test shifts data retrieval")
        var expectedResult: [SHShiftData] = []
        self.shiftLisInteractor?.getShifts(completion: { (result: Result<[SHShiftData], SHError>) in
            switch result {
            case .success(let shifts):
                expectedResult = shifts
                expectation.fulfill()
            case .failure(_ ):
                XCTFail("Should not recieved an error")
            }
        })
        wait(for: [expectation], timeout: 1)
        XCTAssert(!expectedResult.isEmpty)
    }
    
    func testShiftScheduleFormat() throws {
        let expectation = XCTestExpectation(description: "Test shifts data schedule format")
        let start =  "2018-04-20 9:00:00 -08:00"
        let end =  "2018-4-20 12:00:00 -08:00"
        let expectedResult = Date.getFormattedDate(format: "h", from: start) + " - " + Date.getFormattedDate(format: "h a", from: end)
        var firstResult = ""
        self.shiftLisInteractor?.getShifts(completion: { (result: Result<[SHShiftData], SHError>) in
            switch result {
            case .success(let shifts):
                firstResult = shifts.first?.schedule ?? ""
                expectation.fulfill()
            case .failure(_ ):
                XCTFail("Should not recieved an error")
            }
        })
        wait(for: [expectation], timeout: 1)
        XCTAssertEqual(expectedResult, firstResult)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
