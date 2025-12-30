# Primitive types

Variables and symbolic constants:

```kotlin
val constant = "immutable"
var x = "mutable"
x = "mutable variable"
```

## Boolean

```kotlin
val flag: Boolean = true
```

## Numbers

Kotlin's type system is designed around the Java Virtual Machine (JVM) and thus inherits its limitations. Notoriously, Java/JVM doesn't support unsigned integers, so Kotlin uses a workaround to add the support. This is fine in most cases, but can be problematic for Java or iOS interop (KMP). Use at your own risk.
<ref:https://kotlinlang.org/docs/unsigned-integer-types.html>

```kotlin
val b: Byte = 0x7F
val s: Short = 32_767
val i: Int = -2_147_483_648
val l: Long = 1L

// JVM supports only signed integer types. 
// Kotlin offers their unsigned counterparts as custom types layered on top.
// Technically, these are not primitive types, so be careful.
val ub: UByte = 0xFFu
val us: UShort = 65_535U
val ui: UInt = 4_294_967_295u
val ul: ULong = 1UL

var d: Double = 3.14
d = .01
d = 1_001e1_000
d = 1.1E10
var f: Float = 3.14f
f = 1F
```

## Text

```kotlin
var c: Char = 'c'
c = '\n'
c = '\u005C'

var text: String = "Text"
text = """
    Multiline
    text
    """
```

## Anything

A value of any type can be stored in a variable of the common supertype `Any`. Everything inherits from `Any`. However, the type is so general that it's not very useful aside from passing indetermined things around. 

What happens is: A more specific type is _boxed_ and then _unboxed_ when cast back from `Any`. (See below, in <link:data/optionals>.) This has performance cost.

```kotlin
var a: Any = true
a = "some other type"
```

Note: A special `dynamic` type is available for JavaScript targets. It opts out from type checking.
<ref:https://kotlinlang.org/docs/dynamic-type.html>
