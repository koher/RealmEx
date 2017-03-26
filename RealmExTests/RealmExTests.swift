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
        
        measure {
            let selected = realm.objects(Dog.self).filter {
                123456 <= "age" && "age" < 123465
            }
            XCTAssertEqual(selected.count, 9)
            XCTAssertEqual(selected.first!.name, "name0123456")
            XCTAssertEqual(selected.last!.name, "name0123464")
        }
    }
    
    func testExample() {
        /**/ let realm = try! Realm(configuration: Realm.Configuration(inMemoryIdentifier: "RealmExTests"))
        
        /**/ try! realm.write {
        /**/     for i in 0...20 {
        /**/         let dog = Dog()
        /**/         dog.name = String(format: "name%07d", i)
        /**/         dog.age = i
        /**/         realm.add(dog)
        /**/     }
        /**/ }

        /**/ do {
            // without RealmEx
            let pups = realm.objects(Dog.self).filter("age < 2")
            let dogs = realm.objects(Dog.self).filter("2 <= age AND age < 5")
            
            /**/ XCTAssertEqual(pups.count, 2)
            /**/ XCTAssertEqual(dogs.count, 3)
        /**/ }
        
        /**/ do {
            // with RealmEx
            let pups = realm.objects(Dog.self).filter { "age" < 2 }
            let dogs = realm.objects(Dog.self).filter { 2 <= "age" && "age" < 5 }
            
            /**/ XCTAssertEqual(pups.count, 2)
            /**/ XCTAssertEqual(dogs.count, 3)
        /**/ }
    }
}
