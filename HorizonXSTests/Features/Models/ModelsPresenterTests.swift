//
//  ModelsPresenterTests.swift
//  HorizonXS
//
//  Created by Carlos Jimenez on 9/21/19.
//  Copyright (c) 2019 Carlos Jimenez. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

@testable import HorizonXS
import XCTest

// swiftlint:disable all
class ModelsPresenterTests: XCTestCase {
    // MARK: Subject under test

    var sut: ModelsPresenter!

    // MARK: Test lifecycle

    override func setUp() {
        super.setUp()
        setupModelsPresenter()
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: Test setup

    func setupModelsPresenter() {
        sut = ModelsPresenter()
    }

    // MARK: Test doubles

    class ModelsDisplayLogicSpy: ModelsDisplayLogic {
        var displaySomethingCalled = false

        func displaySomething(viewModel: Models.ViewModel) {
            displaySomethingCalled = true
        }
    }

    // MARK: Tests

    func testPresentSomething() {
        // Given
        let spy = ModelsDisplayLogicSpy()
        sut.viewController = spy
        let response = Models.Response()

        // When
        sut.presentSomething(response: response)

        // Then
        XCTAssertTrue(spy.displaySomethingCalled, "presentSomething(response:) should ask the view controller to display the result")
    }
}