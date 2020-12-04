import XCTest
@testable import Inflection

final class ItalianLocalizationTests: LocalizationTestCase {
    override class var locale: Locale { Locale(identifier: "it") }

    override class var pluralizations: [String: String] {
        [
            // Regular
            "gelato": "gelati",
            "donna": "donne",
            "mare": "mari",

            // Words ending with accented letter
            "città": "città",
            "caffè": "caffè",

            // Words ending in "-go"
            "ago": "aghi",

            // Single-syllable words
            "re": "re",
            "gru": "gru",

            // Irregular
            "uomo": "uomini",
            "oasi": "oasi"
        ]
    }
}
