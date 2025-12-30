# Swift/Objective-C interop

With Kotlin Multiplatform, to translate the exceptions to Swift/Objective-C errors properly, functions must be annotated with `@Throws`. Otherwise, the exceptions will be impossible to handle and _will always crash the program_. 

```kotlin
@Throws(IllegalArgumentException::class)
fun bridgedToIOS(param1: Int) {
  require(param1 >= 0)
}
```
