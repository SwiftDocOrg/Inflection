import XCTest
@testable import Inflection

final class SwedishLocalizationTests: LocalizationTestCase {
    override class var locale: Locale { Locale(identifier: "se") }

    override class var pluralizations: [String: String] {
        [
            "flicka": "flickor",
            "pojke": "pojkar",
            "fågel": "fåglar",
            "bil": "bilar",
            "produkt": "produkter",
            "muskel": "muskler",
            "fiende": "fiender",
            "titel": "titlar",
            "vittne": "vittnen",
            "frö": "frön",
            "bok": "böcker",
            "faktum": "fakta",
            "man": "män",
            "mus": "möss",
            "huvud": "huvuden",
            "sko": "skor",
            "hand": "händer",
            "ros": "rosor",
            "kategori": "kategorier",
            "äpple": "äpplen",
            "suddgummi": "suddgummin",
            "minut": "minuter",
            "timme": "timmar",
            "dag": "dagar",
            "vecka": "veckor",
            "månad": "månader"
        ]
    }
}
