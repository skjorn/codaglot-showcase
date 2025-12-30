# Optionals

A variable can be optional and have a value of `null`:

```kotlin
var maybeText: String? = null
maybeText = "A message"
```

Optional unwrapping:

```kotlin
var maybeUppercaseText = maybeText?.substring(2)?.uppercase()

maybeUppercaseText = maybeText?.let { it.substring(2).uppercase() }
```

Fallback value (via so called [Elvis operator](https://en.wikipedia.org/wiki/Elvis_operator)):

```kotlin
val uppercaseText = maybeUppercaseText ?: "EMPTY"
```

Forced unwrapping:

```kotlin
val messageGuaranteed = maybeText!!
val lengthGuaranteed = maybeText!!.length
```

Safe type-casting that succeeds only when the underlying type matches the specified type, otherwise returns `null`:

```kotlin
val typeErasedProperty: Any = "Hidden treasure"
val isItNumber = typeErasedProperty as? Int
val isItString = typeErasedProperty as? String
```
