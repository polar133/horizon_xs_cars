//
//  ManufacturersPresenterTests.swift
//  HorizonXS
//
//  Created by Carlos Jimenez on 9/21/19.
//  Copyright (c) 2019 Carlos Jimenez. All rights reserved.
//
@testable import HorizonXS
import XCTest

// swiftlint:disable all
class ManufacturersPresenterTests: XCTestCase {
    // MARK: Subject under test

    var sut: ManufacturersPresenter!

    // MARK: Test lifecycle

    override func setUp() {
        super.setUp()
        setupManufacturersPresenter()
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: Test setup
    func setupManufacturersPresenter() {
        sut = ManufacturersPresenter()
    }

    // MARK: Tests
    func testPresentManufacturers() {
        // Given
        let spy = ManufacturersDisplayLogicSpy()
        sut.viewController = spy
        let response = Manufacturers.Response(brands: [])

        // When
        sut.presentManufacturers(response: response)

        // Then
        XCTAssertTrue(spy.displaySomethingCalled)
    }

    func testPresentLoading() {
        //Given
        let spy = ManufacturersDisplayLogicSpy()
        sut.viewController = spy

        //When
        sut.presentLoading()

        //Then
        XCTAssertTrue(spy.displayLoadingCalled)
    }

    func testHideLoading() {
        //Given
        let spy = ManufacturersDisplayLogicSpy()
        sut.viewController = spy
        sut.isLoading = true

        //When
        sut.hideLoading()

        //Then
        XCTAssertTrue(spy.hideLoadingCalled)
    }

    func testPresentError() {
        //Given
        let spy = ManufacturersDisplayLogicSpy()
        sut.viewController = spy

        //When
        sut.presentError(msg: "ERROR")

        //Then
        XCTAssertTrue(spy.displayErrorCalled)
    }

    func testHideError() {
        //Given
        let spy = ManufacturersDisplayLogicSpy()
        sut.viewController = spy
        sut.hasError = true

        //When
        sut.hideError()

        //Then
        XCTAssertTrue(spy.hideErrorCalled)
    }
}

// MARK: ManufacturersDisplaySpy
class ManufacturersDisplayLogicSpy: ManufacturersDisplayLogic {

    var displaySomethingCalled = false
    func displaySomething(viewModel: Manufacturers.ViewModel) {
        displaySomethingCalled = true
    }

    var displayLoadingCalled = false
    func displayLoading() {
        displayLoadingCalled = true
    }

    var hideLoadingCalled = false
    func hideLoading() {
        hideLoadingCalled = true
    }

    var displayErrorCalled = false
    func displayError(msg: String) {
        displayErrorCalled = true
    }

    var hideErrorCalled = false
    func hideError() {
        hideErrorCalled = true
    }
}
