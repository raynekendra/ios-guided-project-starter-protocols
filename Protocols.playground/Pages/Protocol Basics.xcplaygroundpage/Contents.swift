import Foundation

//: # Protocols
//: Protocols are, as per Apple's definition in the _Swift Programming Language_ book:
//:
//: "... a blueprint of methods, properties, and other requirements that suit a particular task or piece of functionality. The protocol can then be adopted by a class, structure, or enumeration to provide an actual implementation of those requirements. Any type that satisfies the requirements of a protocol is said to conform to that protocol."
//:
//: The below example shows a protocol that requires conforming types have a particular property defined.


protocol FullyNamed {
    var fullName: String { get }
}
// any property you have has a getter and a setter, th ability to read and to write in that property. you need to have a property that can be read.

struct Person: FullyNamed {
    var fullName: String
}

let johnny = Person(fullName: "Johnny Hicks")
let spencer = Person(fullName: "Spencer Curtis")

class Starship: FullyNamed {
    var prefix: String?
    var name: String
    init(name: String, prefix: String? = nil) {
        self.name = name
        self.prefix = prefix
    }
    // Computer property - has opening  and closing braces like a function, anything in the body will be computed and then returned as its full value. Run a calculation when calling the getter.
    
    var fullName: String {
        // if prefix == nil {
//        return name
//    } else {
//    return prefix! + " " + name
//    } what this is doing vvv
        return (prefix != nil ? prefix! + "" : "") + name
    }
}

var ncc1701 = Starship(name: "Enterprise", prefix: "USS")
ncc1701.fullName

var fireFly = Starship(name: "Serenity")
fireFly.fullName



//: Protocols can also require that conforming types implement certain methods.

protocol GeneratesRandomNumbers {
    func random() -> Int
    //you don't pass in the actual code for the function here
}

//Adopt
class OneThroughTen: GeneratesRandomNumbers {
    //Conform
    func random() -> Int {
        return Int.random(in: 1...10)
    }
}

let rand = OneThroughTen()
rand.random()

class OneThroughOneHundred: GeneratesRandomNumbers {
    func random() -> Int {
        return Int.random(in: 1...100)
    }
}

let rand2 = OneThroughOneHundred()
rand2.random()


//: Using built-in Protocols
// Equatable

//let name1 = "Johnny"
//let name2 = "John"
//
//if name1 == name2 {
//    print("The names are the same")
//} else {
//    print("The names are not the same")
//}
//

extension Starship: Equatable {
    static func == (lhs: Starship, rhs: Starship) -> Bool {
        if lhs.fullName == rhs.fullName { return true }
    return false
        
    }
}

if ncc1701 == fireFly {
    print("The ships are the same")
} else {
    print("The ships are different")
}

//: ## Protocols as Types

class Dice {
    let sides: Int
    let generator: GeneratesRandomNumbers
    
    init(sides: Int, generator: GeneratesRandomNumbers) {
        self.sides = sides
        self.generator = generator
    }
    func roll() -> Int {
        let remainder = generator.random() % sides
        return remainder + 1
    }
}

var d6 = Dice(sides: 6, generator: OneThroughTen())
for _ in 1...5 {
    print("Random dice roll is \(d6.roll())")
}


