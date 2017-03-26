import Foundation
import RealmSwift
import RealmEx

class Dog: Object {
    dynamic var name = ""
    dynamic var age = 0
    
    override static func indexedProperties() -> [String] {
        return ["name", "age"]
    }
}

extension Dog: MetaObjectProducible {
    static var metaObject: MetaDog {
        return MetaDog()
    }
}

struct MetaDog {
    let age: PropertyName = "age"
}
