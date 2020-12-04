import XCTest
@testable import Inflection

final class KazakhLocalizationTests: LocalizationTestCase {
    override class var locale: Locale { Locale(identifier: "kk") }

    override class var pluralizations: [String: String] {
        [
            "сабақ": "сабақтар",
            "мектеп": "мектептер",
            "қағаз": "қағаздар",
            "кілем": "кілемдер",
            "гүл": "гүлдер",
            "бала": "балалар",
            "дәрігер": "дәрігерлер",
            "үй": "үйлер",
            "ескерту": "ескертулер",
            "ауру": "аурулар",
            "дәптер": "дәптерлер",
        ]
    }
}
