//
//  ManufacturersStubs.swift
//  HorizonXSTests
//
//  Created by Carlos Jimenez on 9/21/19.
//  Copyright © 2019 Carlos Jimenez. All rights reserved.
//
import Foundation
import OHHTTPStubs

//swiftlint:disable all
class ManufacturersStubs {

    public func enableStubs() {
        OHHTTPStubs.removeAllStubs()
        let manufacturerFile = "get_manufacturer_200.json"
        stub(condition: isMethodGET()) { _ in
            return fixture(
                filePath: OHPathForFile(manufacturerFile, type(of: self))!,
                status: 200,
                headers: [:]
            )
        }
    }

    public func enableErrorStubs() {
        OHHTTPStubs.removeAllStubs()
        let manufacturerFile = "get_manufacturer_400.json"
        stub(condition: isMethodGET()) { _ in
            return fixture(
                filePath: OHPathForFile(manufacturerFile, type(of: self))!,
                status: 400,
                headers: [:]
            )
        }
    }

    public func enableWrongStubs() {
        OHHTTPStubs.removeAllStubs()
        let manufacturerFile = "get_manufacturer_400.json"
        stub(condition: isMethodGET()) { _ in
            return fixture(
                filePath: OHPathForFile(manufacturerFile, type(of: self))!,
                status: 200,
                headers: [:]
            )
        }
    }
}
