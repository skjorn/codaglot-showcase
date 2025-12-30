# Function types

Functions are first-class citizens and can be stored in a variable:

```kotlin
// Lambda
var fn: (Int, String, Boolean) -> Double = 
  { param1: Int, param2, param3 -> 42.0 }

// Anonymous function
var annotatedFn: (param1: Int, param2: String, param3: Boolean) -> Double = 
  fun(param1: Int, param2: String, param3: Boolean): Double {
    return 42.0
  }

fn = annotatedFn
annotatedFn = fn
```

Anonymous functions can specify the return type and create a scope for the `return` statement, same as in a regular function. `return` works differently for lambdas, see following sections. 

Simplest possible function signature:

```kotlin
val simpleFn: () -> Unit = {
  // Side-effect code goes here, since this function doesn't return anything.
  // Also, there are no parameters.
}
```

Functions with a receiver, a.k.a. extension functions:

```kotlin
var fnWithReceiver: String.(Int) -> String = String::drop
var fnEquivalentWithoutReceiver: (String, Int) -> String = fnWithReceiver
fnWithReceiver = fnEquivalentWithoutReceiver

val light = "flight".fnWithReceiver(1)
val alsoLight = fnWithReceiver("flight", 1)
```

Lambdas with a single parameter can omit the parameter name and use the implicit `it` shorthand:

```kotlin
val implicitLambdaParameter: (Int) -> Int = { it + 1 }
```
