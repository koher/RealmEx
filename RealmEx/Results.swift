import RealmSwift
import Foundation

extension Results {
    public func filter(predicate: () -> RealmExPredicate) -> Results<T> {
        return filter(predicate().predicate)
    }
}