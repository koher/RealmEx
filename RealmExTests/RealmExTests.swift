import XCTest
import RealmSwift
@testable import RealmEx

class RealmExTests: XCTestCase {
    func testBasic() {
        let realm = try! Realm(configuration: Realm.Configuration(inMemoryIdentifier: "RealmExTests"))
        
        try! realm.write {
            for i in 1...1000000 {
                let dog = Dog()
                dog.name = String(format: "name%07d", i)
                dog.age = i
                realm.add(dog)
            }
        }
        
        measureBlock {
            let selected = realm.objects(Dog.self).filter {
                123456 <= "age" && "age" < 123465
            }
            XCTAssertEqual(selected.count, 9)
            XCTAssertEqual(selected.first!.name, "name0123456")
            XCTAssertEqual(selected.last!.name, "name0123464")
        }
    }
}
