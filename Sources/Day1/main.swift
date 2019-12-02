import Day1Lib

class Main {
    func run() {
        let modules = input.split(separator: "\n").lazy
            .map { Int($0)! }
            .map(Module.init(mass:))

        let basicFuelRequired = modules.lazy
            .map { $0.basicFuelRequiredToMove }
            .reduce(into: 0, +=)
        print("Basic Fuel Requied: \(basicFuelRequired)")
        
        let totalFuelRequired = modules.lazy
            .map { $0.totalFuelRequiredToMove() }
            .reduce(into: 0, +=)
        print("Total Fuel Required: \(totalFuelRequired)")
    }
}

Main().run()
