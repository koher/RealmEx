import Foundation

public protocol RealmExValue {
    var RealmEx_object: AnyObject { get }
}

extension Int: RealmExValue {
    public var RealmEx_object: AnyObject {
        return NSNumber(value: self as Int)
    }
}

extension Int8: RealmExValue {
    public var RealmEx_object: AnyObject {
        return NSNumber(value: self as Int8)
    }
}

extension Int16: RealmExValue {
    public var RealmEx_object: AnyObject {
        return NSNumber(value: self as Int16)
    }
}

extension Int32: RealmExValue {
    public var RealmEx_object: AnyObject {
        return NSNumber(value: self as Int32)
    }
}

extension Int64: RealmExValue {
    public var RealmEx_object: AnyObject {
        return NSNumber(value: self as Int64)
    }
}

extension Float: RealmExValue {
    public var RealmEx_object: AnyObject {
        return NSNumber(value: self as Float)
    }
}

extension Double: RealmExValue {
    public var RealmEx_object: AnyObject {
        return NSNumber(value: self as Double)
    }
}

extension String: RealmExValue {
    public var RealmEx_object: AnyObject {
        return self as NSString
    }
}

extension Date: RealmExValue {
    public var RealmEx_object: AnyObject {
        return self as AnyObject
    }
}

public protocol RealmExEquatable: RealmExValue, Equatable {
    static func ==(lhs: PropertyName, rhs: Self) -> RealmExPredicate
    static func ==(lhs: Self, rhs: PropertyName) -> RealmExPredicate
}

extension Int:    RealmExEquatable {}
extension Int8:   RealmExEquatable {}
extension Int16:  RealmExEquatable {}
extension Int32:  RealmExEquatable {}
extension Int64:  RealmExEquatable {}
extension Float:  RealmExEquatable {}
extension Double: RealmExEquatable {}
extension String: RealmExEquatable {}
extension Date:   RealmExEquatable {}

public func ==<T: RealmExEquatable>(lhs: PropertyName, rhs: T) -> RealmExPredicate {
    return op(lhs, "==", rhs)
}

public func ==<T: RealmExEquatable>(lhs: T, rhs: PropertyName) -> RealmExPredicate {
    return op(lhs, "==", rhs)
}

public protocol RealmExComparable: RealmExEquatable, Comparable {
    static func <(lhs: PropertyName, rhs: Self) -> RealmExPredicate
    static func <(lhs: Self, rhs: PropertyName) -> RealmExPredicate
    
    static func <=(lhs: PropertyName, rhs: Self) -> RealmExPredicate
    static func <=(lhs: Self, rhs: PropertyName) -> RealmExPredicate
    
    static func >=(lhs: PropertyName, rhs: Self) -> RealmExPredicate
    static func >=(lhs: Self, rhs: PropertyName) -> RealmExPredicate
    
    static func >(lhs: PropertyName, rhs: Self) -> RealmExPredicate
    static func >(lhs: Self, rhs: PropertyName) -> RealmExPredicate
}

extension Int:    RealmExComparable {}
extension Int8:   RealmExComparable {}
extension Int16:  RealmExComparable {}
extension Int32:  RealmExComparable {}
extension Int64:  RealmExComparable {}
extension Float:  RealmExComparable {}
extension Double: RealmExComparable {}
extension Date:   RealmExComparable {}

public func <<T: RealmExEquatable>(lhs: PropertyName, rhs: T) -> RealmExPredicate {
    return op(lhs, "<", rhs)
}

public func <<T: RealmExEquatable>(lhs: T, rhs: PropertyName) -> RealmExPredicate {
    return op(lhs, "<", rhs)
}

public func <=<T: RealmExEquatable>(lhs: PropertyName, rhs: T) -> RealmExPredicate {
    return op(lhs, "<=", rhs)
}

public func <=<T: RealmExEquatable>(lhs: T, rhs: PropertyName) -> RealmExPredicate {
    return op(lhs, "<=", rhs)
}

public func >=<T: RealmExEquatable>(lhs: PropertyName, rhs: T) -> RealmExPredicate {
    return op(lhs, ">=", rhs)
}

public func >=<T: RealmExEquatable>(lhs: T, rhs: PropertyName) -> RealmExPredicate {
    return op(lhs, ">=", rhs)
}

public func ><T: RealmExEquatable>(lhs: PropertyName, rhs: T) -> RealmExPredicate {
    return op(lhs, ">", rhs)
}

public func ><T: RealmExEquatable>(lhs: T, rhs: PropertyName) -> RealmExPredicate {
    return op(lhs, ">", rhs)
}

private func op<T: RealmExEquatable>(_ lhs: PropertyName, _ oparatorName: String, _ rhs: T) -> RealmExSimplePredicate {
    return RealmExSimplePredicate(format: "\(lhs.value) \(oparatorName) %@", arguments: [rhs.RealmEx_object])
}

private func op<T: RealmExEquatable>(_ lhs: T, _ oparatorName: String, _ rhs: PropertyName) -> RealmExSimplePredicate {
    return RealmExSimplePredicate(format: "%@ \(oparatorName) \(rhs.value)", arguments: [lhs.RealmEx_object])
}
