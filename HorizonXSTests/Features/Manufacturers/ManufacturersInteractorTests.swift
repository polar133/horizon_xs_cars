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
        XCTAssertTrue(spy.presentManufacturersCalled)
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

    func testGetManufacturersLoading() {
        // Given
        let spy = ManufacturersPresentationLogicSpy()
        sut.presenter = spy
        sut.worker = ManufacturersWorkerSpy()
        sut.isLoading = true

        // When
        sut.getManufacturers()

        // Then
        XCTAssertFalse(spy.presentManufacturersCalled)
    }

    func testGetManufacturersLessPages() {
        // Given
        let spy = ManufacturersPresentationLogicSpy()
        sut.presenter = spy
        sut.worker = ManufacturersWorkerSpy()
        sut.currentPage = 100

        // When
        sut.getManufacturers()

        // Then
        XCTAssertFalse(spy.presentManufacturersCalled)
    }

    func testManufacturerSelected() {
        //Given
        let spy = ManufacturersPresentationLogicSpy()
        sut.presenter = spy
        sut.id = ""
        sut.name = ""
        let request = Manufacturers.Request(id: "007", name: "Aston Martin")

        //When
        sut.manufacturerSelected(request: request)

        //Then
        XCTAssertTrue(spy.presentModelCalled)
        XCTAssertEqual(sut.id, "007")
        XCTAssertEqual(sut.name, "Aston Martin")
    }
}

// MARK: Presenter SPY
class ManufacturersPresentationLogicSpy: ManufacturersPresentationLogic {
    var presentModelCalled = false
    func presentModel() {
        presentModelCalled = true
    }

    var presentManufacturersCalled = false
    func presentManufacturers(response: Manufacturers.Response) {
        presentManufacturersCalled = true
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
