// Swift 2.2
import XCTest
import Foundation
import RealmSwift

private let n = 100000
private let numberOfLoops = 1000

class RealmPerformanceTest: XCTestCase {
    func testIndexedIntFilterPerformance() {
        let realm = try! Realm(configuration: Realm.Configuration(inMemoryIdentifier: "RealmPerformanceTest.testIndexedFilterPerformance"))
        
        try! realm.write {
            for i in 0..<n {
                let value = Indexed()
                value.foo = i
                value.bar = i * 2
                realm.add(value)
            }
        }
        
        measureBlock {
            for _ in 1...numberOfLoops {
                let key = Int(arc4random() % UInt32(n))
                let results = realm.objects(Indexed.self).filter("foo = \(key)")
                XCTAssertEqual(results.first!.bar, key * 2)
            }
        }
    }
    
    func testUnindexedIntFilterPerformance() {
        let realm = try! Realm(configuration: Realm.Configuration(inMemoryIdentifier: "RealmPerformanceTest.testUnIndexedFilterPerformance"))
        
        try! realm.write {
            for i in 0..<n {
                let value = Unindexed()
                value.foo = i
                value.bar = i * 2
                realm.add(value)
            }
        }
        
        measureBlock {
            for _ in 1...numberOfLoops {
                let key = Int(arc4random() % UInt32(n))
                let results = realm.objects(Unindexed.self).filter("foo = \(key)")
                XCTAssertEqual(results.first!.bar, key * 2)
            }
        }
    }
    
    func testIndexedStringFilterPerformance() {
        let realm = try! Realm(configuration: Realm.Configuration(inMemoryIdentifier: "RealmPerformanceTest.testIndexedFilterPerformance"))
        
        try! realm.write {
            for i in 0..<n {
                let value = Indexed()
                value.baz = "\(i)"
                value.bar = i * 2
                realm.add(value)
            }
        }
        
        measureBlock {
            for _ in 1...numberOfLoops {
                let key = Int(arc4random() % UInt32(n))
                let results = realm.objects(Indexed.self).filter("baz = %@", "\(key)" as NSString)
                XCTAssertEqual(results.first!.bar, key * 2)
            }
        }
    }
    
    func testUnindexedStringFilterPerformance() {
        let realm = try! Realm(configuration: Realm.Configuration(inMemoryIdentifier: "RealmPerformanceTest.testUnIndexedFilterPerformance"))
        
        try! realm.write {
            for i in 0..<n {
                let value = Unindexed()
                value.baz = "\(i)"
                value.bar = i * 2
                realm.add(value)
            }
        }
        
        measureBlock {
            for _ in 1...numberOfLoops {
                let key = Int(arc4random() % UInt32(n))
                let results = realm.objects(Unindexed.self).filter("baz = %@", "\(key)" as NSString)
                XCTAssertEqual(results.first!.bar, key * 2)
            }
        }
    }
}

class Indexed: Object {
    dynamic var foo: Int = 0
    dynamic var bar: Int = 0
    dynamic var baz: String = ""
    
    override static func indexedProperties() -> [String] {
        return ["foo", "baz"]
    }
}

class Unindexed: Object {
    dynamic var foo: Int = 0
    dynamic var bar: Int = 0
    dynamic var baz: String = ""
}
