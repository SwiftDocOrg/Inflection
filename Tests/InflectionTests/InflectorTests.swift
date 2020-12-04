import XCTest
@testable import Inflection

final class InflectionTests: XCTestCase {
    var inflector: Inflector!

    override func setUp() {
        self.inflector = Inflector()
    }

    func testCustomSingularizationAndPluralization() throws {
        try inflector.addSingularizationRule(matching: #"^(MacBook)s (Pro|Air)?$"#, replacement: #"$1 $2"#)
        try inflector.addPluralizationRule(matching: #"^i(Pod|Pad)( Mini)?$"#, replacement: #"i$1s$2"#)
        inflector.addIrregular(singular: "lol", plural: "lolz")
        inflector.addUncountable("Herokai")

        XCTAssertEqual(inflector.singularize("MacBooks Air"), "MacBook Air")
        XCTAssertEqual(inflector.pluralize("iPad Mini"), "iPads Mini")
        XCTAssertEqual(inflector.pluralize("lol"), "lolz")
        XCTAssertEqual(inflector.pluralize("Herokai"), "Herokai")
    }

    func testHumanization() {
        inflector.addAcronym("SSL")

        XCTAssertEqual(inflector.humanize("employee_salary"), "Employee Salary")

        XCTAssertEqual(inflector.humanize("ssl_error"), "SSL Error")
        XCTAssertEqual(inflector.humanize("employee_id"), "Employee")
    }

    func testUnderscoring() {
        XCTAssertEqual(inflector.underscore("HTTPRequest"), "http_request")
        XCTAssertEqual(inflector.underscore("NSRegularExpression"), "ns_regular_expression")
        XCTAssertEqual(inflector.underscore("Area51Location"), "area51_location")

        XCTAssertEqual(inflector.underscore("AsyncXMLHTTPRequest"), "async_xmlhttp_request")

        inflector.addAcronym("XML")
        inflector.addAcronym("HTTP")
        XCTAssertEqual(inflector.underscore("AsyncXMLHTTPRequest"), "async_xml_http_request")
    }
}
