public struct Wire {
    enum Direction {
        case right(Int)
        case left(Int)
        case up(Int)
        case down(Int)
        
        init<S: StringProtocol>(_ s: S) {
            let count = Int(s.dropFirst())!
            switch s.first! {
            case "R":
                self = .right(count)
            case "L":
                self = .left(count)
            case "U":
                self = .up(count)
            case "D":
                self = .down(count)
            default:
                fatalError("Invalid Input")
            }
        }
    }
    
    fileprivate enum Path: CustomStringConvertible {
        case empty
        case origin
        case one
        case two
        case intersection
        
        var description: String {
            switch self {
            case .empty:
                return "."
            case .origin:
                return "o"
            case .one:
                return "1"
            case .two:
                return "2"
            case .intersection:
                return "x"
            }
        }
    }
    
    let directions: [Direction]
    let width: Int
    let height: Int
    let origin: Point
    
    public init<S: StringProtocol>(_ path: S) {
        let directions = path.split(separator: ",").map(Direction.init)
        self.directions = directions
        
        var leftEdge = 0
        var rightEdge = 0
        var topEdge = 0
        var bottomEdge = 0
        var position: (x: Int, y: Int) = (0, 0)
        directions.forEach { direction in
            switch direction {
            case let .right(count):
                position.x += count
            case let .left(count):
                position.x -= count
            case let .up(count):
                position.y += count
            case let .down(count):
                position.y -= count
            }
            
            if position.x < leftEdge {
                leftEdge = position.x
            } else if position.x > rightEdge {
                rightEdge = position.x
            }
            
            if position.y < bottomEdge {
                bottomEdge = position.y
            } else if position.y > topEdge {
                topEdge = position.y
            }
        }
        width = rightEdge - leftEdge + 2
        height = topEdge - bottomEdge + 2
        origin = Point(x: -leftEdge, y: -bottomEdge)
    }
    
    public func intersections(with other: Wire) -> (Set<Point>, origin: Point) {
        let overlayWidth = Swift.max(width, other.width) + abs(origin.x - other.origin.x)
        let overlayHeight = Swift.max(height, other.height) + abs(origin.y - other.origin.y)
        let overlayOrigin = Point(x: Swift.max(origin.x, other.origin.x), y: Swift.max(origin.y, other.origin.y))
        
        var overlay = [[Path]](repeating: [Path](repeating: .empty, count: overlayWidth), count: overlayHeight)
        
        var currentPosition = overlayOrigin
        overlay[currentPosition] = .origin

        directions.forEach { direction in
            var moveCount: Int
            var offset: Point
            switch direction {
            case let .right(count):
                moveCount = count
                offset = .init(x: 1, y: 0)
            case let .left(count):
                moveCount = count
                offset = .init(x: -1, y: 0)
            case let .up(count):
                moveCount = count
                offset = .init(x: 0, y: 1)
            case let .down(count):
                moveCount = count
                offset = .init(x: 0, y: -1)
            }
            
            for _ in 0 ..< moveCount {
                currentPosition += offset
                overlay[currentPosition] = .one
            }
        }
        
        var intersections: Set<Point> = []
        currentPosition = overlayOrigin
        other.directions.forEach { direction in
            var moveCount: Int
            var offset: Point
            switch direction {
            case let .right(count):
                moveCount = count
                offset = .init(x: 1, y: 0)
            case let .left(count):
                moveCount = count
                offset = .init(x: -1, y: 0)
            case let .up(count):
                moveCount = count
                offset = .init(x: 0, y: 1)
            case let .down(count):
                moveCount = count
                offset = .init(x: 0, y: -1)
            }
            
            for _ in 0 ..< moveCount {
                currentPosition += offset
                switch overlay[currentPosition] {
                case .empty:
                    overlay[currentPosition] = .two
                case .origin:
                    break
                case .one:
                    overlay[currentPosition] = .intersection
                    intersections.insert(currentPosition)
                case .two:
                    break
                case .intersection:
                    break
                }
            }
        }
        
        return (intersections, overlayOrigin)
    }
}

fileprivate extension Array where Element == [Wire.Path] {
    subscript(point: Point) -> Wire.Path {
        get { self[point.y][point.x] }
        set { self[point.y][point.x] = newValue }
    }
}
