public struct Intcode {
    var values: [Int]
    
    private static let opcodeStep = 4
    
    public func computeOpcode() -> String {
        var opcode = self.values
        var opcodeIndex = 0
        var running = true
        
        var firstIndex: Int { opcode[opcodeIndex + 1] }
        var secondIndex: Int { opcode[opcodeIndex + 2] }
        var thridIndex: Int{ opcode[opcodeIndex + 3] }
        
        var firstValue: Int { opcode[firstIndex] }
        var secondValue: Int { opcode[secondIndex] }
        var thirdValue: Int {
            get { fatalError("Will not be called") }
            set { opcode[thridIndex] = newValue }
        }
        
        while running {
            defer { opcodeIndex += Self.opcodeStep }

            switch opcode[opcodeIndex] {
            case 1:
                let addedValues = firstValue + secondValue
                thirdValue = addedValues
            case 2:
                let multipliedValues = firstValue * secondValue
                thirdValue = multipliedValues
            case 99:
                running = false
            default:
                fatalError("Invalid opcode found")
            }
        }
        
        return opcode.lazy
            .map(String.init)
            .reduce(into: "") {
            if !$0.isEmpty {
                $0 += ","
            }
            $0 += $1
        }
    }
    
    public func computeNounAndVerb(whereFirstIs target: Int, in range: ClosedRange<Int>) -> String {
        let (noun, verb) = range.lazy
            .flatMap { noun -> [(Int, Int)] in
                range.map { verb -> (Int, Int) in
                    (noun, verb)
                }
            }
            .first { noun, verb -> Bool in
                var valuesCopy = values
                valuesCopy[1] = noun
                valuesCopy[2] = verb
                let first = Intcode(valuesCopy).computeOpcode().split(separator: ",").first.map { Int($0) }!
                return first == target
            }!
        return "\(noun),\(verb)"
    }
    
    public init(_ input: String) {
        values = input.split(separator: ",").lazy.map { Int($0)! }
    }
    
    private init(_ values: [Int]) {
        self.values = values
    }
}
