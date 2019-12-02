import XCTest
@testable import Day01Lib

final class Day01LibTests: XCTestCase {
    func testPart1() {
        XCTAssertEqual(Module(mass: 12).basicFuelRequiredToMove, 2)
        XCTAssertEqual(Module(mass: 14).basicFuelRequiredToMove, 2)
        XCTAssertEqual(Module(mass: 1969).basicFuelRequiredToMove, 654)
        XCTAssertEqual(Module(mass: 100756).basicFuelRequiredToMove, 33583)
    }

    func testPart2() {
        XCTAssertEqual(Module(mass: 1), Module(mass: 1))
        XCTAssertEqual(Module(mass: 14).totalFuelRequiredToMove(), 2)
        XCTAssertEqual(Module(mass: 1969).totalFuelRequiredToMove(), 966)
        XCTAssertEqual(Module(mass: 100756).totalFuelRequiredToMove(), 50346)
    }
}
