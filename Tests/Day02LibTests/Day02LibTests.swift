import XCTest
@testable import Day02Lib

final class Day02LibTests: XCTestCase {
    func testPart1() {
        XCTAssertEqual(Intcode("1,9,10,3,2,3,11,0,99,30,40,50").computeOpcode(), "3500,9,10,70,2,3,11,0,99,30,40,50")
        XCTAssertEqual(Intcode("1,0,0,0,99").computeOpcode(), "2,0,0,0,99")
        XCTAssertEqual(Intcode("2,3,0,3,99").computeOpcode(), "2,3,0,6,99")
        XCTAssertEqual(Intcode("2,4,4,5,99,0").computeOpcode(), "2,4,4,5,99,9801")
        XCTAssertEqual(Intcode("1,1,1,4,99,5,6,0,99").computeOpcode(), "30,1,1,4,2,5,6,0,99")
    }

    func testPart2() {
        
    }
}
