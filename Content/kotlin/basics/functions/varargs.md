# Variadic functions

Function with unlimited number of arguments (of the same type):

```kotlin
fun collect(vararg numbers: Int): List&lt;Int&gt; {
  return numbers.toList()
}
```

It can have also other parameters, but only one can be marked as `vararg`:

```kotlin
fun collectProxy(mock: List&lt;Int&gt;? = null, vararg numbers: Int): List&lt;Int&gt; {
  return mock ?: collect(*numbers)
}

collectProxy(null, 1, 2, 3)
collectProxy(numbers = intArrayOf(1, 2, 3))
```

Variadic parameter doesn't have to be the last (although usually it is):

```kotlin
fun collectProxy2(vararg numbers: Int, mock: List&lt;Int&gt;? = null): List&lt;Int&gt; {
  return mock ?: collect(*numbers)
}

collectProxy2(1, 2, 3)
collectProxy2(mock = listOf(1, 2, 3))
```
