# Jumps

## Break

Exit a loop early:

```kotlin
for (i in 1..5) {
  if (i == 3) break
}
```

## Continue

Skip an iteration of the loop:

```kotlin
for (i in 1..5) {
  if (i == 3) continue
}
```

## Labels

Use labels to exit several nested loops early or skip outer iterations from a nested loop:

```kotlin
outerLoop@ for (i in 1..10) {
  for (j in 1..10) {
    if (i > j) break@outerLoop
  }
}

outerLoop@ for (i in 1..10) {
  for (j in 1..10) {
    if (i == 5 && j == 5) continue@outerLoop
  }
}
```

Labels also work for lambdas. They are the only way to exit early from lambdas, via the so called "qualified returns". Depending on use, they can behave as `break` or `continue`.

```kotlin
var positiveSum = listOf(-1, -2, 2, 1).reduce lambda@{ acc, it ->
  // Continue with explicit label
  if (acc >= 50) return@lambda acc
  if (it > 0) acc + it else acc
}

positiveSum = listOf(-1, -2, 2, 1).reduce { acc, it ->
  // Continue with implicit label
  if (acc >= 50) return@reduce acc
  if (it > 0) acc + it else acc
}

val initialNumbers = mutableListOf&lt;Int&gt;()
run abort@{
  listOf(1, 2, "three", null, true).forEach {
    // Break
    if (it !is Int) return@abort
    initialNumbers.add(it)
  }
}
```
