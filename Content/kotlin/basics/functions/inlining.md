# Inlining

Inline functions are an optimization. They are sort of macros that unfold their code at the places they are used. Since they are essentially templates to be copy-pasted, they cannot be referenced for later use or stored in a variable. 

To opt out a lambda inside an inlined function from inlining, `noinline` modifier can be used.

```kotlin
inline fun joinWithSideEffect(
  source: Iterable&lt;String&gt;,
  separator: (Pair&lt;String, Int&gt;, Pair&lt;String, Int&gt;) -> String,
  noinline sideEffect: (String) -> Unit
): String {
  if (source.count() < 2) {
    return source.firstOrNull()?.also { sideEffect(it) } ?: ""
  }

  return source
    .windowed(2)
    .foldIndexed("") { index, acc, window ->
      var chunk = ""
      if (index == 0) {
        chunk = window[0]
        sideEffect(chunk)
      }

      chunk += separator(window[0] to index, window[1] to (index + 1))
      chunk += window[1]
      (acc + chunk).also(sideEffect)
    }
}

joinWithSideEffect(listOf("one", "two"), separator = { _, _ -> ", " }) {}
```

Inlined functions with inlined lambdas can behave unexpectedly with regular `return`s. Such `return`s are _non-local_ and exit the encompassing scope! You can prohibit such behavior with `crossinline` modifier.

```kotlin
fun scopedJoin(): String {
  return joinWithSideEffect(
    listOf("one", "two"),
    // Non-local returns are allowed inside inlined lambdas. 
    // They return from the encompassing scope!
    separator = { _, _ -> return "Surprise!" }
  ) {}
}

inline fun joinWithoutSurprise(
  source: Iterable&lt;String&gt;,
  crossinline separator: (Pair&lt;String, Int&gt;, Pair&lt;String, Int&gt;) -> String,
  noinline sideEffect: (String) -> Unit
) = joinWithSideEffect(source, separator, sideEffect)
```
