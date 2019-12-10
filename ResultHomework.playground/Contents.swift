import Foundation

// Implement an Error type. Make sure it has at least two values.
let illegalWords = ["hi", "cat", "thermonuclear"]
enum IllegalString: Error, LocalizedError {
    case stringEmpty
    case stringAllWhitespace
    case containedIllegalWord(String)
    
    var errorDescription: String? {
        switch self {
        case .stringEmpty:
            return NSLocalizedString("Your string cannot be empty", comment: "")
        case .stringAllWhitespace:
            return NSLocalizedString("Your string cannot be all whitespace", comment: "")
        case .containedIllegalWord(let word):
            return NSLocalizedString("Your string cannot contain illegal words. Found '\(word)'", comment: "")
        }
        
    }
}

// Implement a function that returns a Result of string or your error type
func stringManipulator(str: String) throws -> String {
    guard str != "" else {
        throw IllegalString.stringEmpty
    }
    guard str.trimmingCharacters(in: .whitespacesAndNewlines) != "" else {
        throw IllegalString.stringAllWhitespace
    }
    for word in str.split(whereSeparator: { !$0.isLetter }) {
        guard !illegalWords.contains(String(word)) else {
            throw IllegalString.containedIllegalWord(String(word))
        }
    }
    
    let newStr = str + " " + str.reversed()
    
    return newStr
    
}

// Call your function in a way that will return an error result, and handle that error.
do {
    print(try stringManipulator(str: "hi"))
    
} catch {
    print("you have an error: \(error.localizedDescription)")
}
do {
    print(try stringManipulator(str: " "))
    
} catch {
    print("you have an error: \(error.localizedDescription)")
}

// Call your function in a way that will return a success result, and handle the value.
do {
    print(try stringManipulator(str: "Greetings, this meercat is nonthermonuclear"))
    
} catch {
    print("you have an error: \(error.localizedDescription)")
}
