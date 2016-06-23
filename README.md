# RealmEx

___RealmEx___ enables to write predicates of `filter` with natural Swift's operators without losing benefits of indices.

```swift
// let pups = realm.objects(Dog.self).filter("age < 2")
let pups = realm.objects(Dog.self).filter { "age" < 2 }

// let dogs = realm.objects(Dog.self).filter("2 <= age AND age < 5")
let dogs = realm.objects(Dog.self).filter { 2 <= "age" && "age" < 5 }
```
