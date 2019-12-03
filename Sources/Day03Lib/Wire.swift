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
    
    fileprivate typealias OverlayValue = (path: Path, step1: Int, step2: Int)
    
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
    
    public func intersections(with other: Wire) -> (Set<Point>, origin: Point, steps: [Point: Int]) {
        let overlayWidth = max(width, other.width) + abs(origin.x - other.origin.x)
        let overlayHeight = max(height, other.height) + abs(origin.y - other.origin.y)
        let overlayOrigin = Point(x: max(origin.x, other.origin.x), y: max(origin.y, other.origin.y))
        
        var overlay = [[OverlayValue]](repeating: [OverlayValue](repeating: (.empty, .max, .max), count: overlayWidth), count: overlayHeight)
        
        var currentPosition = overlayOrigin
        var stepCount = 0
        overlay[currentPosition].path = .origin

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
                stepCount += 1
                overlay[currentPosition].path = .one
                overlay[currentPosition].step1 = min(overlay[currentPosition].step1, stepCount)
            }
        }
        
        currentPosition = overlayOrigin
        stepCount = 0
        var intersections: Set<Point> = []
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
                stepCount += 1
                switch overlay[currentPosition].path {
                case .empty:
                    overlay[currentPosition].path = .two
                    overlay[currentPosition].step2 = min(overlay[currentPosition].step2, stepCount)
                case .origin:
                    break
                case .one:
                    overlay[currentPosition].path = .intersection
                    overlay[currentPosition].step2 = min(overlay[currentPosition].step2, stepCount)
                    intersections.insert(currentPosition)
                case .two:
                    break
                case .intersection:
                    break
                }
            }
        }
        
        return (intersections, overlayOrigin, .init(uniqueKeysWithValues: intersections.map { intersection -> (Point, Int) in
            let value = overlay[intersection]
            return (intersection, value.step1 + value.step2)
        }))
    }
}

fileprivate extension Array where Element == [Wire.OverlayValue] {
    subscript(point: Point) -> Wire.OverlayValue {
        get { self[point.y][point.x] }
        set { self[point.y][point.x] = newValue }
    }
}
