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

    // MARK: Test doubles

    class ManufacturersPresentationLogicSpy: ManufacturersPresentationLogic {
        var presentSomethingCalled = false

        func presentSomething(response: Manufacturers.Response) {
            presentSomethingCalled = true
        }
    }

    // MARK: Tests

    func testDoSomething() {
        // Given
        let spy = ManufacturersPresentationLogicSpy()
        sut.presenter = spy
        let request = Manufacturers.Request()

        // When
        sut.doSomething(request: request)

        // Then
        XCTAssertTrue(spy.presentSomethingCalled, "doSomething(request:) should ask the presenter to format the result")
    }
}
