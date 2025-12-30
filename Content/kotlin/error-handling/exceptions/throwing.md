# Throwing exceptions

You can throw an exception anywhere and you are not required to declare or handle it. It will bubble up the call stack.

Quick and dirty. Ideally, you would use a more [specific subtype of exception](#custom-exceptions) to provide more details about what happened.

```kotlin
throw Exception()
throw Exception("Something bad happened")
```

Root hierarchy. Every exception is `Throwable` and will be a child of one of these:

```kotlin
val baseExceptions: Iterable&lt;Throwable&gt; = listOf(
  Exception("Errors that make sense to handle"),
  RuntimeException(
    "A programming error that can be prevented by refactoring the code"
  ),
  Error("Errors you can't do much about")
)

for (e in baseExceptions) throw e
```

Non-recoverable errors:

```kotlin
val fatalErrors: Iterable&lt;Error&gt; = listOf(
  OutOfMemoryError(),
  StackOverflowError()
)
```

Exceptions that can be handled:

```kotlin
val anyExceptionToHandle: Iterable&lt;Exception&gt; = listOf(
  RuntimeException(),
  java.io.IOException(),
  java.util.zip.DataFormatException()
)
```

Exceptions that can be prevented by writing better code, usually result of validation:

```kotlin
val runtimeIssues: Iterable&lt;RuntimeException&gt; = listOf(
  IllegalArgumentException(),
  IllegalStateException(),
  ArithmeticException()
)
```

## Custom exceptions

```kotlin
class CorruptRemoteDataError: Error(
  "Bad external data that renders the app totally unusable"
) {}

class ImportFailedException: Exception(
  "An external cause that we can handle gracefully"
) {}

class OldCacheFormatException: RuntimeException(
  "Edge case that can be prevented by more checks, " +
  "or it can serve as a trigger to handle a rare special case"
) {}
```

## Preconditions

There are handy functions that can validate input parameters and invariants quickly: `require`, `check`, `error`, with `...NotNull` flavors.

```kotlin
var state: Map&lt;String, Boolean&gt; = mapOf("initialized" to true)

fun doSomething(input: Collection&lt;String&gt;): String {
  require(input.isNotEmpty()) // throw IllegalArgumentException()

  val initialized = 
    checkNotNull(state["initialized"]) // throw IllegalStateException()
  check(initialized) // throw IllegalStateException()

  return input.joinToString(", ") {
    if (it == "BANG!")
      error("Invalid instruction!") // throw IllegalStateException()
    else
      it
  }
}
```
