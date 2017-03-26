# RealmEx

___RealmEx___ enables to write predicates of `filter` with natural Swift's operators without losing benefits of indices.

```swift
// without RealmEx
let pups = realm.objects(Dog.self).filter("age < 2")
let dogs = realm.objects(Dog.self).filter("2 <= age AND age < 5")

// with RealmEx
let pups = realm.objects(Dog.self).filter { "age" < 2 }
let dogs = realm.objects(Dog.self).filter { 2 <= "age" && "age" < 5 }

// with RealmEx using `MetaObject`
let pups = realm.objects(Dog.self).filter { $0.age < 2 }
let dogs = realm.objects(Dog.self).filter { 2 <= $0.age && $0.age < 5 }
```

To use `MetaObject`, it is necessary to declare `MetaObject`.

```swift
extension Dog: MetaObjectProducible {
    static var metaObject: MetaDog {
        return MetaDog()
    }
}

struct MetaDog {
    let age: PropertyName = "age"
}
```
