# Functions

A typical function with inputs and outputs. It can be called in many different ways; default arguments, named parameters, and trailing lambdas supported:

```kotlin
fun doSomething(
  times: Int, notifyAfterEachStep: Boolean = true, something: () -> Unit
): List&lt;String&gt; {
  val result = mutableListOf&lt;String&gt;()

  for (i in 1..times) {
    something()
    if (notifyAfterEachStep) {
      result.add("Step $i finished")
    }
  }

  result.add("Done")
  return result
}

doSomething(3, false, {})
doSomething(3) {}
doSomething(something = {}, times = 3)
doSomething(3, something = {})
```

A function without inputs or outputs that does something cryptic inside. Technically, it's not a function, but a procedure.

```kotlin
fun sideEffect() {}
```

A function can be referenced for later use:

```kotlin
doSomething(1, something = ::sideEffect)
```

A function that is implemented by a single expression:

```kotlin
fun toString(x: Any) = "$x"
```

Functions can nest:

```kotlin
fun histogram(text: String): Map&lt;Char, Int&gt; {
  val result = mutableMapOf&lt;Char, Int&gt;()
  fun recordLetter(char: Char) {
    val count = result.getOrDefault(char, 0)
    result[char] = count + 1
  }

  for (c in text) recordLetter(c)
  return result
}
```
