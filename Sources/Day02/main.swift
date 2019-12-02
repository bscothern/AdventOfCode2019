import Day02Lib

class Main {
    func run() {
        let intcode1 = Intcode(input)
        print("Opcode 1: \(intcode1.computeOpcode())")
        
        let intcode2 = Intcode(input)
        print("Opcode 2: \(intcode2.computeNounAndVerb(whereFirstIs: 19690720, in: 0...99))")
    }
}

Main().run()
