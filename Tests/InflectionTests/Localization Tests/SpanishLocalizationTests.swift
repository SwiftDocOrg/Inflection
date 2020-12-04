import XCTest
@testable import Inflection

final class SpanishLocalizationTests: LocalizationTestCase {
    override class var locale: Locale { Locale(identifier: "es") }

    override class var pluralizations: [String: String] {
        [
            // Regular
            "libro": "libros",
            "radio": "radios",
            "señor": "señores",
            "ley": "leyes",
            "casa": "casas",
            "perro": "perros",
            "árbol": "árboles",
            "álbum": "álbumes",
            "mujer": "mujeres",

            // Words ending in "z"
            "mez": "meces",
            "luz": "luces",

            // Words ending in "n" or "s" without accents
            "avión": "aviones",
            "interés": "intereses",

            // Irregular
            "el": "los",
            "mequetrefe": "mequetrefes",
            "pasaje": "pasajes",
            "fase": "fases",
            "pez": "peces"
        ]
    }
}
