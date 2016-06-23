import Foundation

public protocol RealmExValue {
    var RealmEx_object: AnyObject { get }
}

extension Int: RealmExValue {
    public var RealmEx_object: AnyObject {
        return NSNumber(integer: self)
    }
}

extension Int8: RealmExValue {
    public var RealmEx_object: AnyObject {
        return NSNumber(char: self)
    }
}

extension Int16: RealmExValue {
    public var RealmEx_object: AnyObject {
        return NSNumber(short: self)
    }
}

extension Int32: RealmExValue {
    public var RealmEx_object: AnyObject {
        return NSNumber(int: self)
    }
}

extension Int64: RealmExValue {
    public var RealmEx_object: AnyObject {
        return NSNumber(longLong: self)
    }
}

extension Float: RealmExValue {
    public var RealmEx_object: AnyObject {
        return NSNumber(float: self)
    }
}

extension Double: RealmExValue {
    public var RealmEx_object: AnyObject {
        return NSNumber(double: self)
    }
}

extension String: RealmExValue {
    public var RealmEx_object: AnyObject {
        return self as NSString
    }
}

extension NSDate: RealmExValue {
    public var RealmEx_object: AnyObject {
        return self
    }
}

public protocol RealmExEquatable: RealmExValue, Equatable {
    func ==(lhs: PropertyName, rhs: Self) -> RealmExPredicate
    func ==(lhs: Self, rhs: PropertyName) -> RealmExPredicate
}

extension Int:    RealmExEquatable {}
extension Int8:   RealmExEquatable {}
extension Int16:  RealmExEquatable {}
extension Int32:  RealmExEquatable {}
extension Int64:  RealmExEquatable {}
extension Float:  RealmExEquatable {}
extension Double: RealmExEquatable {}
extension String: RealmExEquatable {}
extension NSDate: RealmExEquatable {}

public func ==<T: RealmExEquatable>(lhs: PropertyName, rhs: T) -> RealmExPredicate {
    return op(lhs, "==", rhs)
}

public func ==<T: RealmExEquatable>(lhs: T, rhs: PropertyName) -> RealmExPredicate {
    return op(lhs, "==", rhs)
}

public protocol RealmExComparable: RealmExEquatable, Comparable {
    func <(lhs: PropertyName, rhs: Self) -> RealmExPredicate
    func <(lhs: Self, rhs: PropertyName) -> RealmExPredicate
    
    func <=(lhs: PropertyName, rhs: Self) -> RealmExPredicate
    func <=(lhs: Self, rhs: PropertyName) -> RealmExPredicate
    
    func >=(lhs: PropertyName, rhs: Self) -> RealmExPredicate
    func >=(lhs: Self, rhs: PropertyName) -> RealmExPredicate
    
    func >(lhs: PropertyName, rhs: Self) -> RealmExPredicate
    func >(lhs: Self, rhs: PropertyName) -> RealmExPredicate
}

extension Int:    RealmExComparable {}
extension Int8:   RealmExComparable {}
extension Int16:  RealmExComparable {}
extension Int32:  RealmExComparable {}
extension Int64:  RealmExComparable {}
extension Float:  RealmExComparable {}
extension Double: RealmExComparable {}
extension NSDate: RealmExComparable {}

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

private func op<T: RealmExEquatable>(lhs: PropertyName, _ oparatorName: String, _ rhs: T) -> RealmExSimplePredicate {
    return RealmExSimplePredicate(format: "\(lhs.value) \(oparatorName) %@", arguments: [rhs.RealmEx_object])
}

private func op<T: RealmExEquatable>(lhs: T, _ oparatorName: String, _ rhs: PropertyName) -> RealmExSimplePredicate {
    return RealmExSimplePredicate(format: "%@ \(oparatorName) \(rhs.value)", arguments: [lhs.RealmEx_object])
}

public func <(lhs: NSDate, rhs: NSDate) -> Bool {
    switch lhs.compare(rhs) {
    case .OrderedAscending:
        return true
    default:
        return false
    }
}