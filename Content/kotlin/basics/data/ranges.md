# Ranges

Basic ranges:

```kotlin
val closedRange = 1..10 // 10 included
val openRange = 1..<10 // Up to 10, excluded
```

Checking if a range contains or doesn't contain an element:

```kotlin
val isFiveInRange = 5 in closedRange
val isTwentyNotInRange = 20 !in closedRange
```

Fancy ranges:

```kotlin
var range = 1..10 step 2
range = 10 downTo 1
range = 20 downTo 1 step 2
```
