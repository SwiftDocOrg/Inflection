import XCTest
@testable import Inflection

final class LatinLocalizationTests: LocalizationTestCase {
    override class var locale: Locale { Locale(identifier: "la") }

    override class var pluralizations: [String: String] {
        [
            // First declension
            "poeta": "poetae",

            // Second declension masculine
            "somnus": "somni",

            // Second declension neuter
            "donum": "dona",

            // Third declension gendered
            "pater": "patres",
            "puer": "pueri",

            // Third declension neuter
            "nomen": "nomina",

            // Fourth declension gendered
            "cursus": "cursūs",

            // Fourth declension neuter
            "cornu": "cornua",

            // Fifth declension
            "res": "res"
        ]
    }
}
