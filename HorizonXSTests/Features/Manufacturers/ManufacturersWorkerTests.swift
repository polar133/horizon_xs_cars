//
//  ManufacturersWorkerTests.swift
//  HorizonXS
//
//  Created by Carlos Jimenez on 9/21/19.
//  Copyright (c) 2019 Carlos Jimenez. All rights reserved.
//
@testable import HorizonXS
import XCTest

// swiftlint:disable all
class ManufacturersWorkerTests: XCTestCase {

    // MARK: Subject under test
    var sut: ManufacturersWorker!

    // MARK: Test lifecycle
    override func setUp() {
        super.setUp()
        setupManufacturersWorker()
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: Get File
    func loadResponse() -> ManufacturersEntity? {
        let bundle = Bundle(for: ManufacturersWorkerTests.classForCoder())
        let jsonFile =  bundle.path(forResource: "get_manufacturer_200", ofType: "json")
        let data = try? Data(contentsOf: URL(fileURLWithPath: jsonFile!), options: [])
        let serialized = try? JSONDecoder().decode(ManufacturersEntity.self, from: data!)
        return serialized
    }

    // MARK: Test setup

    func setupManufacturersWorker() {
        sut = ManufacturersWorker()
    }

    // MARK: Tests
    func testFetchManufacturers() {
        //Given
        ManufacturersStubs().enableStubs()
        var response: ManufacturersEntity?
        let expected = loadResponse()
        let expectation = self.expectation(description: "Fetch manufacturers")

        //When
        sut.fetchManufacturers(page: 0) { result in
            switch result {
            case .success(let data):
                response = data
            default:
                break
            }
            expectation.fulfill()
        }

        //Then
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertNotNil(response)
        XCTAssertEqual(response, expected)
    }

    func testErrorFetchManufacturers() {
        //Given
        ManufacturersStubs().enableErrorStubs()
        var response: XSError?
        let expected = XSError.unknown
        let expectation = self.expectation(description: "Fetch manufacturers")

        //When
        sut.fetchManufacturers(page: 0) { result in
            switch result {
            case .failure(let error):
                response = error
            default:
                break
            }
            expectation.fulfill()
        }

        //Then
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertNotNil(response)
        XCTAssertEqual(response, expected)
    }

    func testWrongFetchManufacturers() {
        //Given
        ManufacturersStubs().enableWrongStubs()
        var response: XSError?
        let expected = XSError.responseSerialization
        let expectation = self.expectation(description: "Fetch manufacturers")

        //When
        sut.fetchManufacturers(page: 0) { result in
            switch result {
            case .failure(let error):
                response = error
            default:
                break
            }
            expectation.fulfill()
        }

        //Then
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertNotNil(response)
        XCTAssertEqual(response, expected)
    }
}
