//
//  MockedData.swift
//  GH StargazersTests
//
//  Created by Emanuel Carnevale on 15/10/2020.
//

import Foundation
import UIKit

/// Contains all available Mocked data.
public final class MockedData {
    public static let emptyData: URL = Bundle(for: MockedData.self).url(forResource: "Resources/emptyData", withExtension: "json")!
    public static let notFoundRepo: URL = Bundle(for: MockedData.self).url(forResource: "Resources/notFoundRepo", withExtension: "json")!
    public static let correctData: URL = Bundle(for: MockedData.self).url(forResource: "Resources/correctData", withExtension: "json")!
    public static let paginationData: URL = Bundle(for: MockedData.self).url(forResource: "Resources/paginationData", withExtension: "json")!
    public static let paginationData2: URL = Bundle(for: MockedData.self).url(forResource: "Resources/paginationData2", withExtension: "json")!
}

internal extension URL {
    /// Returns a `Data` representation of the current `URL`. Force unwrapping as it's only used for tests.
    var data: Data {
        return try! Data(contentsOf: self)
    }
}
