import RealmSwift

public protocol MetaObjectProducible {
    associatedtype MetaObject
    
    static var metaObject: MetaObject { get }
}

extension Results where T: MetaObjectProducible {
    public func filter(_ predicate: (T.MetaObject) -> RealmExPredicate) -> Results<T> {
        return filter(predicate(T.metaObject).predicate)
    }
}
