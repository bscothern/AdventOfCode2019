import Day03Lib

class Main {
    func run() {
        let wires = input.split(separator: "\n").map(Wire.init)
        let (intersections, origin) = wires[0].intersections(with: wires[1])
        let closestIntersection = intersections.closestPoint(to: origin)!
        print("Distance: \(closestIntersection.manhattanDistance(to: origin))")
    }
}

Main().run()
