# Collections

## List

Random-access, iterable sequence, read-only or mutable. `List` and `MutableList` are interfaces that can have different underlying implementations (e.g., linked list, array, stack). The default implementation is a resizable array (`ArrayList`). It is recommended to use these general interfaces over more specific types like [Array](#array), for example. Rationale is the same as for [Java Collections](http://www.javapractices.com/topic/TopicAction.do?Id=39).

```kotlin
var readOnlyList: List&lt;Int&gt; = emptyList()
readOnlyList = listOf(1, 2, 3)

val listSize = "List has ${readOnlyList.size} elements"
val firstListElement = "The first element is ${readOnlyList[0]}"
val alsoFirstListElement = "The first element is still ${readOnlyList.get(0)}"
val isFourOnTheList = 4 in readOnlyList
val isFourOnTheListAlternative = readOnlyList.contains(4)

val mutableList = mutableListOf&lt;Int&gt;()
mutableList.add(2)
mutableList.add(0, 1)
mutableList.addAll(arrayOf(3, 4))
mutableList.removeAt(2)
mutableList[mutableList.lastIndex] = 3

mutableList == readOnlyList
mutableList != readOnlyList
```

## Stack and queue

Implemented by double-ended queue called `ArrayDeque` in Kotlin. It's a special case of a `MutableList`.

```kotlin
val queue = ArrayDeque(listOf(1, 2, 3))
val peekFirstElement = "First element: ${queue.first()}"
val firstQueueElement = queue.removeFirstOrNull()
queue.addLast(4)
queue.addFirst(1)
queue[1] = 5

val stack = ArrayDeque&lt;Int&gt;()
stack.addLast(1)
stack.addLast(2)
val peekTopElement = "Last element: ${queue.last()}"
val topStackElement = stack.removeLastOrNull()
```

## Map

Key-value store that is also known as "dictionary" or "associative array".

```kotlin
val readOnlyMap: Map&lt;String, Int&gt; = mapOf("one" to 1, "two" to 2, "twoAgain" to 2)
val mapValueOne = readOnlyMap["one"]
"three" in readOnlyMap
3 in readOnlyMap.values
readOnlyMap.containsKey("three")
readOnlyMap.containsValue(3)

var mutableMap: MutableMap&lt;String, Int&gt; = mutableMapOf()
mutableMap["first"] = 1
mutableMap.put("second", 2)
mutableMap.put("first", 2)
mutableMap["second"] = 1
mutableMap.remove("first")

mapOf("one" to 1, "two" to 2) == mutableMapOf("two" to 2, "one" to 1)
mapOf("one" to 1) != mapOf("two" to 2)
```

## Set

A collection of unique elements with undefined order. However, a `Set` is also iterable and provides random access via indices! The default implementation of `MutableSet` is `LinkedHashSet`, which stores elements in the order they were inserted. An alternative, `HashSet`, is more efficient, but doesn't preserve the order.

```kotlin
var readOnlySet: Set&lt;Int&gt; = emptySet()
readOnlySet = setOf(1, 2, 3)
readOnlySet = arrayOf(1, 2, 3, 3, 2, 1).toSet()
val setSize = "Set has ${readOnlySet.size} elements"
val isFourInTheSet = readOnlySet.contains(4)
val isFourInTheSetAlternative = 4 in readOnlySet

val mutableSet: MutableSet&lt;Int&gt; = mutableSetOf()
mutableSet.add(1)
mutableSet.addAll(readOnlySet)
mutableSet.remove(4)

mutableSet == readOnlySet
mutableSet != readOnlySet

val unionSet: Set&lt;Int&gt; = mutableSet.union(readOnlySet)
val intersectionSet: Set&lt;Int&gt; = unionSet.intersect(mutableSet)
val differenceSet: Set&lt;Int&gt; = unionSet.subtract(intersectionSet)
```

## Array

`Array` is a more efficient, lower-level implementation of a random-access, fixed size, iterable sequence. It is always fixed size, mutable, and occupies a contiguous memory region. There are only very specific situations that require it; otherwise the more flexible [List](#list) should be preferred.

To compare array contents, special functions `contentEquals` and `contentDeepEquals` should be used, as opposed to `List`s and other `Collection`s where you should rely on operators `==` and `!=`.
<ref:https://kotlinlang.org/docs/arrays.html>

```kotlin
val arrayIsAlwaysFixedSize = emptyArray&lt;String&gt;()

val arrayIsAlwaysMutable = arrayOf(1, 2, 3)
arrayIsAlwaysMutable[0] = 10

val jaggedTwoDArray = Array(2) { Array(it + 1) { 0 } }
jaggedTwoDArray[0][0] = 1

arrayOf(1, 2, 3) contentEquals arrayOf(1, 2, 3)
arrayOf(1, 2, 3) contentDeepEquals jaggedTwoDArray

arrayOf(1, 2, 3).toList()
arrayOf(1, 2, 3).toSet()

val arrayOfPairs: Array&lt;Pair&lt;Int, String&gt;&gt; = 
  arrayOf(1 to "one", 2 to "two", 3 to "three")
arrayOfPairs.toMap()
```

## Primitive-type arrays

For primitive types, `Array`s can be even more optimized by using primitive-type arrays that don't box their values into `Object`s.

```kotlin
// More efficient arrays for primitive types without boxing

val arrayOfInts: IntArray = arrayOf(1, 2, 3).toIntArray()
val arrayOfBooleans: BooleanArray = booleanArrayOf(true, false)
val arrayOfChars: CharArray = "Hello".toCharArray()

val boxedAgain: Array&lt;Char&gt; = arrayOfChars.toTypedArray()
```
