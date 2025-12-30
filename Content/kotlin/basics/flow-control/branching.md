# Branching

## If

```kotlin
if (true) {
  "Do something in a block".lowercase()
}
```

If-else:

```kotlin
if (true)
  "Then a single statement".lowercase()
else
  "Some other statement. These could also be blocks.".lowercase()
```

If-else can be used as an expression that returns a value that you can assign to a variable or return as a result of a function. There is no dedicated ternary operator per se.

```kotlin
var conditionalText = if (true) "ternary" else "operator"
conditionalText = if (false) {
  "Also do something else before. Last value is the result of the expression.".lowercase()
  "ternary"
} else {
  "Else is mandatory here".lowercase()
  "operator"
}
```

## When

Switch looks like this:

```kotlin
val magicBag = mutableListOf&lt;Any&gt;()

when (conditionalText) {
  "ternary" -> magicBag.add(0, "ternary")
  "discombobulate" -> magicBag.add(0, "when doesn't need to be exhaustive as statement")
}

when (conditionalText) {
  "operator" -> {
    "Branches can be blocks".lowercase()
    magicBag.add(0, "These can contain more than one statement")
  }
  "other", "options", "same", "branch" -> 
    magicBag.add(0, "One-liners can be mixed with blocks at will")
  else -> {
    magicBag.add(0, "Default branch")
  }
}
```

Switches can also be used as expressions and assigned to variables:

```kotlin
conditionalText = when (conditionalText) {
  "switch" -> "when"
  "when" -> "when"
  else -> "when must be exhaustive as expression"
}
```

`When` doesn't require a target to compare against. Its branches can be a loose collection of arbitrary conditions. And you can also assign to a scoped variable that can be used only inside `when`.

```kotlin
when {
  magicBag.isNotEmpty() -> magicBag.clear()
  else -> Unit // Do nothing
}

when (val size = magicBag.size) {
  in 1..<10 -> conditionalText = "Size is $size"
  !in 1..<10 -> conditionalText = "Size is too big"
}
```
