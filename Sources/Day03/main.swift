import Day03Lib

class Main {
    func run() {
        let wires = input.split(separator: "\n").map(Wire.init)
        let (intersections, origin, steps) = wires[0].intersections(with: wires[1])
        let closestIntersection = intersections.closestPoint(to: origin)!
        print("Origin: \(origin)")
        print("Distance: \(closestIntersection.manhattanDistance(to: origin))")
        print("Min Steps: \(steps.min(by: { $0.1 < $1.1 })!.value)")
    }
}

Main().run()
