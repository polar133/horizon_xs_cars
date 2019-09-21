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

    // MARK: Test doubles

    class ManufacturersDisplayLogicSpy: ManufacturersDisplayLogic {
        var displaySomethingCalled = false

        func displaySomething(viewModel: Manufacturers.ViewModel) {
            displaySomethingCalled = true
        }
    }

    // MARK: Tests

    func testPresentSomething() {
        // Given
        let spy = ManufacturersDisplayLogicSpy()
        sut.viewController = spy
        let response = Manufacturers.Response()

        // When
        sut.presentSomething(response: response)

        // Then
        XCTAssertTrue(spy.displaySomethingCalled, "presentSomething(response:) should ask the view controller to display the result")
    }
}
