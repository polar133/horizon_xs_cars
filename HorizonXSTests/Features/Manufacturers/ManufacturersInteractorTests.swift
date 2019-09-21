//
//  ManufacturersInteractorTests.swift
//  HorizonXS
//
//  Created by Carlos Jimenez on 9/21/19.
//  Copyright (c) 2019 Carlos Jimenez. All rights reserved.
//
@testable import HorizonXS
import XCTest

// swiftlint:disable all
class ManufacturersInteractorTests: XCTestCase {
    // MARK: Subject under test

    var sut: ManufacturersInteractor!

    // MARK: Test lifecycle

    override func setUp() {
        super.setUp()
        setupManufacturersInteractor()
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: Test setup
    func setupManufacturersInteractor() {
        sut = ManufacturersInteractor()
    }

    // MARK: Tests
    func testGetManufacturers() {
        // Given
        let spy = ManufacturersPresentationLogicSpy()
        sut.presenter = spy
        sut.worker = ManufacturersWorkerSpy()

        // When
        sut.getManufacturers()

        // Then
        XCTAssertTrue(spy.presentSomethingCalled)
    }

    func testGetManufacturerseError() {
        // Given
        let spy = ManufacturersPresentationLogicSpy()
        sut.presenter = spy
        sut.worker = ManufacturersWorkerErrorSpy()

        // When
        sut.getManufacturers()

        // Then
        XCTAssertTrue(spy.presentErrorCalled)
    }
    
}

// MARK: Presenter SPY
class ManufacturersPresentationLogicSpy: ManufacturersPresentationLogic {
    var presentSomethingCalled = false
    func presentManufacturers(response: Manufacturers.Response) {
        presentSomethingCalled = true
    }
    var presentLoadingCalled = false
    func presentLoading() {
        presentLoadingCalled = true
    }
    var hideLoadingCalled = false
    func hideLoading() {
        hideLoadingCalled = true
    }
    var presentErrorCalled = false
    func presentError(msg: String) {
        presentErrorCalled = true
    }
    var hideErrorCalled = false
    func hideError() {
        hideErrorCalled = true
    }
}

// MARK: Workers SPY
class ManufacturersWorkerSpy: ManufacturersWorker {

    override func fetchManufacturers(page: Int = 0, callback: @escaping (Result<ManufacturersEntity>) -> Void) {
        let bundle = Bundle(for: ManufacturersWorkerTests.classForCoder())
        let jsonFile =  bundle.path(forResource: "get_manufacturer_200", ofType: "json")
        let data = try? Data(contentsOf: URL(fileURLWithPath: jsonFile!), options: [])
        let serialized = try? JSONDecoder().decode(ManufacturersEntity.self, from: data!)
        callback(.success(serialized!))
    }
}

class ManufacturersWorkerErrorSpy: ManufacturersWorker {

    override func fetchManufacturers(page: Int = 0, callback: @escaping (Result<ManufacturersEntity>) -> Void) {
        callback(.failure(.responseSerialization))
    }
}
