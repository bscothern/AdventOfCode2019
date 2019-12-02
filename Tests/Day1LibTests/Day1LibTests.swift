import XCTest
@testable import Day1Lib

final class Day1LibTests: XCTestCase {
    func testBasicExamples() {
        XCTAssertEqual(Module(mass: 12).basicFuelRequiredToMove, 2)
        XCTAssertEqual(Module(mass: 14).basicFuelRequiredToMove, 2)
        XCTAssertEqual(Module(mass: 1969).basicFuelRequiredToMove, 654)
        XCTAssertEqual(Module(mass: 100756).basicFuelRequiredToMove, 33583)
    }

    func testTotalExamples() {
        XCTAssertEqual(Module(mass: 1), Module(mass: 1))
        XCTAssertEqual(Module(mass: 14).totalFuelRequiredToMove(), 2)
        XCTAssertEqual(Module(mass: 1969).totalFuelRequiredToMove(), 966)
        XCTAssertEqual(Module(mass: 100756).totalFuelRequiredToMove(), 50346)
    }
}
