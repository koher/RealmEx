import Foundation

public protocol RealmExPredicate {
    var predicate: NSPredicate { get }
}

public struct RealmExSimplePredicate: RealmExPredicate {
    public let format: String
    public let arguments: [AnyObject]
    
    public var predicate: NSPredicate {
        return NSPredicate(format: format, argumentArray: arguments)
    }
}

public struct RealmExAndPredicate: RealmExPredicate {
    public let lhs: RealmExPredicate
    public let rhs: RealmExPredicate
    
    public var predicate: NSPredicate {
        return NSCompoundPredicate(andPredicateWithSubpredicates: [lhs.predicate, rhs.predicate])
    }
}

public struct RealmExOrPredicate: RealmExPredicate {
    public let lhs: RealmExPredicate
    public let rhs: RealmExPredicate
    
    public var predicate: NSPredicate {
        return NSCompoundPredicate(orPredicateWithSubpredicates: [lhs.predicate, rhs.predicate])
    }
}

public struct RealmExNotPredicate: RealmExPredicate {
    public let original: RealmExPredicate
    
    public var predicate: NSPredicate {
        return NSCompoundPredicate(notPredicateWithSubpredicate: original.predicate)
    }
}

public func &&(lhs: RealmExPredicate, rhs: RealmExPredicate) -> RealmExAndPredicate {
    return RealmExAndPredicate(lhs: lhs, rhs: rhs)
}

public func ||(lhs: RealmExPredicate, rhs: RealmExPredicate) -> RealmExOrPredicate {
    return RealmExOrPredicate(lhs: lhs, rhs: rhs)
}

public prefix func !(x: RealmExPredicate) -> RealmExNotPredicate {
    return RealmExNotPredicate(original: x)
}