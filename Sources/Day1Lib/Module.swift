//
//  Module.swift
//  
//
//  Created by Braden Scothern on 12/1/19.
//

public struct Module: Equatable {
    public var mass: Int
    
    public var basicFuelRequiredToMove: Int { mass.asMassCalculateFuel() }
    
    public func totalFuelRequiredToMove() -> Int {
        var total = 0
        var current = basicFuelRequiredToMove
        while current > 0 {
            total += current
            current = current.asMassCalculateFuel()
        }
        return total
    }

    public init(mass: Int) {
        self.mass = mass
    }
}

private extension Int {
    func asMassCalculateFuel() -> Int {
        self / 3 - 2
    }
}
