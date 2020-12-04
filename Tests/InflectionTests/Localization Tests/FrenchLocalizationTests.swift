import XCTest
@testable import Inflection

final class FrenchLocalizationTests: LocalizationTestCase {
    override class var locale: Locale { Locale(identifier: "fr") }

    override class var pluralizations: [String: String] {
        [
            // Regular
            "ami": "amis",
            "fidèle": "fidèles",
            "rapport": "rapports",

            // Forms with "x" ending
            "tuyau": "tuyaux",
            "genou": "genoux",
            "aveu": "aveux",
            "nouveau": "nouveaux",
            "bleu": "bleus",
            "landau": "landaus",

            // Words ending in "-al"
            "journal": "journaux",

            // Words ending in "-ail"
            "détail": "détails",
            "travail": "travaux",
            "bail": "baux",
            "émail": "émaux"
        ]
    }
}
