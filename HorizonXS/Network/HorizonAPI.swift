//
//  HorizonAPI.swift
//  HorizonXS
//
//  Created by Carlos Jimenez on 9/21/19.
//  Copyright © 2019 Carlos Jimenez. All rights reserved.

import Foundation

enum Result<T> {
    case success(T)
    case failure(XSError)
}

enum HorizonAPI {

    fileprivate static var baseConfigurationDictionary: [String: Any] {
        let bundle = Bundle.main
        guard let resourcePath = bundle.url(forResource: "api", withExtension: "plist"), let data = try? Data(contentsOf: resourcePath) else {
            return [:]
        }
        do {
            return try PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [String: Any] ?? [:]
        } catch {
            return [:]
        }
    }

    fileprivate static func configurationValueForKeyAndSubKey(key: String, subKey: String, baseConfigurationDictionary: [String: Any]) -> String {
        return baseConfigurationDictionary[key] as? String ?? ""
    }

    fileprivate static var BaseURL: String {
        return configurationValueForKeyAndSubKey(key: "base_url", subKey: "", baseConfigurationDictionary: baseConfigurationDictionary)
    }

    fileprivate static var Version: String {
        return configurationValueForKeyAndSubKey(key: "version", subKey: "", baseConfigurationDictionary: baseConfigurationDictionary)
    }

    static var SecretKey: String {
        return configurationValueForKeyAndSubKey(key: "secret_key", subKey: "", baseConfigurationDictionary: baseConfigurationDictionary)
    }

    static var Manufacturer: String {
        let endpoint = configurationValueForKeyAndSubKey(key: "manufacturer", subKey: "", baseConfigurationDictionary: baseConfigurationDictionary)
        return "\(BaseURL)/\(Version)/\(endpoint)"
    }

    static var Models: String {
        let endpoint = configurationValueForKeyAndSubKey(key: "models", subKey: "", baseConfigurationDictionary: baseConfigurationDictionary)
        return "\(BaseURL)/\(Version)/\(endpoint)"
    }

}
