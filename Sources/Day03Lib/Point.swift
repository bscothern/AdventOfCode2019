public struct Point: Hashable {
    public static let zero = Point(x: 0, y: 0)
    
    public let x: Int
    public let y: Int
    
    public func manhattanDistance(to destination: Point) -> Int {
        abs(x - destination.x) + abs(y - destination.y)
    }
    
    public init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
    
    static func + (lhs: Point, rhs: Point) -> Point {
        .init(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }

    static func += (lhs: inout Point, rhs: Point) {
        lhs = lhs + rhs
    }
}

public extension Sequence where Element == Point {
    func closestPoint(to target: Point = Point.zero) -> Point? {
        self.min { first, second -> Bool in
            first.manhattanDistance(to: target) < second.manhattanDistance(to: target)
        }
    }
}
