import XCTest
@testable import Inflection

final class EnglishLocalizationTests: LocalizationTestCase {
    override class var locale: Locale { Locale(identifier: "en") }

    override class var pluralizations: [String: String] {
        [
            "person": "people",
            "tomato": "tomatoes",
            "matrix": "matrices",
            "octopus": "octopi",
            "fish": "fish",
            "police": "police",
            "cow": "cows"
        ]
    }
}
