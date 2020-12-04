import XCTest
@testable import Inflection

final class BrazillianPortugueseLocalizationTests: LocalizationTestCase {
    override class var locale: Locale { Locale(identifier: "pt-BR") }

    override class var pluralizations: [String: String] {
        [
            // Regular
            "livro": "livros",
            "radio": "radios",
            "senhor": "senhores",
            "lei": "leis",
            "rei": "reis",
            "casa": "casas",
            "árvore": "árvores",
            "cor": "cores",
            "álbum": "álbuns",
            "mulher": "mulheres",

            // Forms ending in "-z"
            "luz": "luzes",
            "juiz": "juizes",

            // Forms ending in "-n" or "-s" with an accent
            "avião": "aviões",
            "cão": "cães",
            "interesse": "interesses",
            "ás": "ases",
            "mão": "mãos",
            "peão": "peões",

            // Irregular
            "nação": "nações",
            "país": "paises",
        ]
    }
}
