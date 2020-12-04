import XCTest
@testable import Inflection

final class NorwegianBokmalLocalizationTests: LocalizationTestCase {
    override class var locale: Locale { Locale(identifier: "nb") }

    override class var pluralizations: [String: String] {
        [
            "hund": "hunder",
            "dag": "dager",
            "test": "tester",
            "lærer": "lærere",
            "kalender": "kalendere",
            "bakke": "bakker",
            "eple": "epler",
            "konto": "konti"
        ]
    }
}
