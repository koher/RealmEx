import RealmSwift
import Foundation

extension Results {
    public func filter(_ predicate: () -> RealmExPredicate) -> Results<T> {
        return filter(predicate().predicate)
    }
}
