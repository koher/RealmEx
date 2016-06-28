# RealmEx

___RealmEx___ enables to write predicates of `filter` with natural Swift's operators without losing benefits of indices.

```swift
// without RealmEx
let pups = realm.objects(Dog.self).filter("age < 2")
let dogs = realm.objects(Dog.self).filter("2 <= age AND age < 5")

// with RealmEx
let pups = realm.objects(Dog.self).filter { "age" < 2 }
let dogs = realm.objects(Dog.self).filter { 2 <= "age" && "age" < 5 }
```
