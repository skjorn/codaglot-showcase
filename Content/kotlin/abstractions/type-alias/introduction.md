# Type alias

Lets you create alternative names for a type.

Supports generic parameters.

```kotlin
typealias SegmentationPool = MutableMap&lt;String, MutableList&lt;Int&gt;&gt;
typealias Predicate&lt;T&gt; = (T) -> Boolean

val predicate: Predicate&lt;Int&gt; = { it > 0 }
val filter: (Int) -> Boolean = predicate
```
