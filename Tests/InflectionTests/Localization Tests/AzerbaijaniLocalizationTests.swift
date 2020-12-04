import XCTest
@testable import Inflection

final class AzerbaijaniLocalizationTests: LocalizationTestCase {
    override class var locale: Locale { Locale(identifier: "az") }

    override class var pluralizations: [String: String] {
        [
            // Regular
            "zürafə": "zürafələr",
            "insan": "insanlar",
            "kitab": "kitablar",
            "pişik": "pişiklər",
            "inqilabçı": "inqilabçılar",
            "kommunist": "kommunistlər",
            "kişi": "kişilər",
            "qadın": "qadınlar",

            // Irregular
            "mən": "biz",
            "sən": "siz",
            "o": "onlar",
            "əhali": "əhali",
            "camaat": "camaat"
        ]
    }
}
