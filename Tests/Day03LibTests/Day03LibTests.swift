import XCTest
@testable import Day03Lib

final class Day03LibTests: XCTestCase {
    func testClosestPoint() {
        XCTAssertEqual([Point(x: 3, y: 3), Point(x: 6, y: 5)].closestPoint(), Point(x: 3, y: 3))
        XCTAssertEqual([Point(x: 3, y: 3), Point(x: 6, y: 5), Point(x: 2, y: 2)].closestPoint(), Point(x: 2, y: 2))
    }
    
    func testExample1() {
        let wire1 = Wire("R8,U5,L5,D3")
        let wire2 = Wire("U7,R6,D4,L4")
        let intersection = wire1.intersections(with: wire2)
        XCTAssertEqual(intersection.0, Set<Point>([Point(x: 3, y: 3), Point(x: 6, y: 5)]))
        XCTAssertEqual(intersection.0.closestPoint(), Point(x: 3, y: 3))
    }
    
    func testPart1() {
    }

    func testPart2() {
    }
}
