# String interpolation

Simple concatenation:

```kotlin
val count = 4
val concatenated = "Count to " + count
```

String interpolation via templates:

```kotlin
val simpleTemplate = "Count to $count"

val curlyTemplate = "Count to ${count + 1}"
```

Multiline strings and escaping `'$'` sign:

```kotlin
var withDollarSign = "Costs \$_5"
withDollarSign = """
  Costs ${'$'}_5
  """
```

## Multiline text without indentation

Special methods can remove the initial indentation:

```kotlin
val withoutInitialSpace = """
  Nice in code, but ugly when printed.
    Can we remove the space, please? 
""".trimIndent()
/*---
Nice in code, but ugly when printed.
  Can we remove the space, please?
---*/

val withoutDesignatedIndentation = """
  |Nice in code, but ugly when printed.
    |Can we remove the space, please? 
""".trimMargin()
/*---
Nice in code, but ugly when printed.
Can we remove the space, please?
---*/
```
