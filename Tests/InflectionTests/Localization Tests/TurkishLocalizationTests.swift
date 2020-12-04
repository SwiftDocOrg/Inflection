import XCTest
@testable import Inflection

final class TurkishLocalizationTests: LocalizationTestCase {
    override class var locale: Locale { Locale(identifier: "tr") }

    override class var pluralizations: [String: String] {
        [
            // Regular
            "gün": "günler",
            "kiraz": "kirazlar",
            "kitap": "kitaplar",
            "köpek": "köpekler",
            "test": "testler",
            "üçgen": "üçgenler",

            // Irregular
            "ben": "biz",
            "sen": "siz",
            "o": "onlar"
        ]
    }
}
