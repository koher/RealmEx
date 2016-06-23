import Foundation
import RealmSwift

class Dog: Object {
    dynamic var name = ""
    dynamic var age = 0
    
    override static func indexedProperties() -> [String] {
        return ["name", "age"]
    }
}