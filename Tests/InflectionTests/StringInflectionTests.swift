import XCTest
@testable import Inflection

final class StringInflectionTests: XCTestCase {
    func testCamelization() {
        XCTAssertEqual("employee_salary".camelized(), "employeeSalary")
        XCTAssertEqual("employee_salary".camelized(uppercasingFirstLetter: true), "EmployeeSalary")
    }

    func testDasherization() {
        XCTAssertEqual("puni_puni".dasherized(), "puni-puni")
    }

    func testHumanization() {
        XCTAssertEqual("employee_salary".humanized(), "Employee Salary")
        XCTAssertEqual("employee_id".humanized(), "Employee")
    }

    func testParameterization() {
        XCTAssertEqual("Donald E. Knuth".parameterized(), "donald-e-knuth")
        XCTAssertEqual("^très|Jolie-- ".parameterized(), "tres-jolie")
    }

    func testPluralization() {
        XCTAssertEqual("person".pluralized(), "people")
        XCTAssertEqual("tomato".pluralized(), "tomatoes")
        XCTAssertEqual("matrix".pluralized(), "matrices")
        XCTAssertEqual("octopus".pluralized(), "octopi")
        XCTAssertEqual("fish".pluralized(), "fish")
        XCTAssertEqual("police".pluralized(), "police")
        XCTAssertEqual("cow".pluralized(), "cows")
    }

    func testSingularization() {
        XCTAssertEqual("people".singularized(), "person")
        XCTAssertEqual("tomatoes".singularized(), "tomato")
        XCTAssertEqual("matrices".singularized(), "matrix")
        XCTAssertEqual("analyses".singularized(), "analysis")
        XCTAssertEqual("octopi".singularized(), "octopus")
        XCTAssertEqual("fish".singularized(), "fish")
        XCTAssertEqual("police".singularized(), "police")
    }

    func testTitleization() {
        XCTAssertEqual("TheManWithoutAPast".titleized(), "The Man Without A Past")
        XCTAssertEqual("raiders_of_the_lost_ark".titleized(), "Raiders Of The Lost Ark")
        XCTAssertEqual("string_ending_with_id".titleized(preservingIDSuffix: true), "String Ending With Id")
    }

    func testUnderscoring() {
        XCTAssertEqual("HTTPRequest".underscored(), "http_request")
    }
}
