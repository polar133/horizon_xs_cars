//
//  ManufacturersRouter.swift
//  HorizonXS
//
//  Created by Carlos Jimenez on 9/21/19.
//  Copyright (c) 2019 Carlos Jimenez. All rights reserved.
//
import Foundation

protocol ManufacturersRoutingLogic {
    //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol ManufacturersDataPassing {
    var dataStore: ManufacturersDataStore? { get }
}

class ManufacturersRouter: NSObject, ManufacturersRoutingLogic, ManufacturersDataPassing {
    weak var viewController: ManufacturersViewController?
    var dataStore: ManufacturersDataStore?

    // MARK: Routing

    //func routeToSomewhere(segue: UIStoryboardSegue?)
    //{
    //  if let segue = segue {
    //    let destinationVC = segue.destination as! SomewhereViewController
    //    var destinationDS = destinationVC.router!.dataStore!
    //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //  } else {
    //    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    //    let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
    //    var destinationDS = destinationVC.router!.dataStore!
    //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //    navigateToSomewhere(source: viewController!, destination: destinationVC)
    //  }
    //}

    // MARK: Navigation

    //func navigateToSomewhere(source: ManufacturersViewController, destination: SomewhereViewController)
    //{
    //  source.show(destination, sender: nil)
    //}

    // MARK: Passing data

    //func passDataToSomewhere(source: ManufacturersDataStore, destination: inout SomewhereDataStore)
    //{
    //  destination.name = source.name
    //}
}
