import XCTest
@testable import Inflection

#if os(macOS)
open class LocalizationTestCase: XCTestCase {
    open class var locale: Locale { .current }
    open class var pluralizations: [String: String] { [:] }

    var inflector: Inflector!
    var singular: String!
    var plural: String!

    public final override class var defaultTestSuite: XCTestSuite {
        let suite = XCTestSuite(forTestCaseClass: self)

        let inflector = Inflector.default(for: locale)!

        for (singular, plural) in pluralizations {
            suite.addTest(pluralization(of: singular, is: plural, with: inflector))
            suite.addTest(singularization(of: plural, is: singular, with: inflector))
        }

        return suite
    }

    static func singularization(of plural: String, is singular: String, with inflector: Inflector) -> XCTest {
        let test = LocalizationTestCase(selector: #selector(assertSingularization))
        test.inflector = inflector
        test.singular = singular
        test.plural = plural
        return test
    }

    static func pluralization(of singular: String, is plural: String, with inflector: Inflector) -> XCTest {
        let test = LocalizationTestCase(selector: #selector(assertPluralization))
        test.inflector = inflector
        test.singular = singular
        test.plural = plural
        return test
    }

    @objc func assertPluralization() {
        let actual = inflector.pluralize(singular)
        let expected = plural!
        let message = #"In \#(localeName), the expected pluralization of "\#(singular!)" is "\#(expected)", not "\#(actual)""#

        XCTAssertEqual(actual, expected, message)
    }

    @objc func assertSingularization() {
        let actual = inflector.singularize(plural)
        let expected = singular!
        let message = #"In \#(localeName), the expected singularization of "\#(plural!)" is "\#(expected)", not "\#(actual)""#

        XCTAssertEqual(actual, expected, message)
    }

    private var localeName: String {
        Locale.current.localizedString(forIdentifier: inflector.locale.identifier) ?? "\(inflector.locale.identifier) locale"
    }
}
#else
open class LocalizationTestCase: XCTestCase {
    open class var locale: Locale { .current }
    open class var pluralizations: [String: String] { [:] }
}
#endif
