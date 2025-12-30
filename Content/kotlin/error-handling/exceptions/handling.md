# Handling exceptions

Try-catch:

```kotlin
try {
  doSomething(emptyList())
} catch (e: IllegalArgumentException) {
  e.stackTraceToString()
}
```

React differently to different types of exceptions. The topmost catch with a matching type wins, so the most specific exception types should come first. 

```kotlin
try {
  doSomething(listOf("BANG!"))
} catch (e: IllegalStateException) {
  doSomething(listOf("most specific exception first"))
} catch (e: RuntimeException) {
  e.stackTraceToString()
} catch (e: Exception) {
  throw Error("Rethrowing a different error with cause attached", e)
}
```

Try-catch can be used as an expression and the exception variable can be ignored:

```kotlin
val output = try {
  doSomething(listOf("item"))
} catch (_: Exception) {
  "empty"
}
```

## Finally

Always execute something after a block of code, regardless if an exception was thrown:

```kotlin
var resource: Collection&lt;String&gt;? = null

try {
  resource = listOf("BANG!")
  resource?.let {
    doSomething(it)
  }
} finally {
  resource = null
}

try {
  resource = listOf("BANG!")
  resource?.let {
    doSomething(it)
  }
} catch (e: Exception) {
  e.stackTraceToString()
} finally {
  resource = null
}
```

`finally` can also be used in a try-catch expression, without influencing the result.

```kotlin
val finalOutput = try {
  resource = listOf("BANG!")
  resource?.let {
    doSomething(it)
  } ?: error("Fallback to default in the catch handler")
} catch (_: Exception) {
  "finally block doesn't affect the result of a try-catch expression"
} finally {
  resource = null
}
```
