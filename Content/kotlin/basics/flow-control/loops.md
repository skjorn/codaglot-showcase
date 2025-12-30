# Loops

## For-loop

For-loops are only for iterating over sequences (e.g., collections or ranges) in Kotlin.

```kotlin
val loopingCollection = listOf("one", "two", "three")
var loopingResult = ""
for (element in loopingCollection) {
  loopingResult += element + ", "
}

loopingResult = ""
for ((index, element) in loopingCollection.withIndex()) {
  loopingResult += "$element [$index], "
}
```

## While-loop

```kotlin
var loopingResult = ""
while (loopingResult.isEmpty()) {
  loopingResult = "Loops are fun"
}
```

## Do-while-loop

```kotlin
var loopingResult = "Loops are fun"
do {
  loopingResult.dropLast(1)
} while (loopingResult.isNotEmpty())
```
