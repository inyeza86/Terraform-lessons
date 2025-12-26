# Terraform `lookup()` and `element()` Functions

This README explains the **`lookup()`** and **`element()`** functions in Terraform, when to use them, and modern best practices. It also covers related functions like **`try()`** and **`coalesce()`**, with real AWS examples.

---

## Overview

Terraform provides built-in functions to safely access values from collections:

* **`lookup()`** → Access values from **maps / objects**
* **`element()`** → Access values from **lists / tuples** (with index wrapping)

Understanding the difference helps prevent subtle bugs and improves module reliability.

---

## `lookup()` Function

### Purpose

Safely retrieve a value from a **map** by key, with a default fallback if the key does not exist.

### Syntax

```hcl
lookup(map, key, default)
```

### Example: Environment-Based Instance Types

```hcl
variable "environment" {
  type = string
}

variable "instance_types" {
  type = map(string)
  default = {
    dev  = "t3.micro"
    qa   = "t3.small"
    prod = "t3.large"
  }
}

resource "aws_instance" "app" {
  instance_type = lookup(var.instance_types, var.environment, "t3.micro")
}
```

### When to Use `lookup()`

* You are working with **maps or objects**
* The key may be missing
* You want a **safe default value**

### Common Use Cases

* Environment-based configuration
* Optional resource attributes
* Tag lookups

---

## `element()` Function

### Purpose

Retrieve a value from a **list** by index, with automatic **index wrapping**.

### Syntax

```hcl
element(list, index)
```

### Example: Subnet Round-Robin (Legacy Pattern)

```hcl
variable "subnet_ids" {
  type = list(string)
}

resource "aws_instance" "app" {
  count     = 3
  subnet_id = element(var.subnet_ids, count.index)
}
```

### Important Behavior

If the index exceeds the list length, Terraform wraps around:

```text
index = 3, list length = 3 → uses index 0
```

### When to Use `element()`

* You are working with **lists**
* You explicitly want **round-robin behavior**
* You understand and accept index wrapping

⚠️ **Not recommended for most modern Terraform code**

---

## Modern Terraform Best Practices

### Avoid `element()` When Possible

❌ Risky:

```hcl
subnet_id = element(var.subnet_ids, count.index)
```

✅ Safer:

```hcl
subnet_id = var.subnet_ids[count.index]
```

This fails fast if the index is invalid and avoids silent bugs.

---

## Prefer `for_each` Over `count`

```hcl
resource "aws_instance" "app" {
  for_each  = toset(var.subnet_ids)
  subnet_id = each.value
}
```

Benefits:

* No index math
* Cleaner state management
* Terraform-recommended approach

---

## `lookup()` vs `try()` vs `coalesce()`

### `lookup()` – Maps Only

```hcl
lookup(var.tags, "Environment", "dev")
```

* Works only with maps
* Explicit and readable

---

### `try()` – Recommended for Modern Terraform

```hcl
instance_type = try(
  var.instance.instance_type,
  var.defaults.instance_type,
  "t3.micro"
)
```

* Handles missing attributes
* Handles `null`
* Works with maps, lists, and objects

---

### `coalesce()` – First Non-Null Value

```hcl
instance_type = coalesce(
  var.custom_instance_type,
  var.default_instance_type,
  "t3.micro"
)
```

* Only checks for `null`
* Errors if the attribute does not exist

---

## Function Comparison

| Function   | Collection Type | Handles Missing Keys | Handles Null | Notes            |
| ---------- | --------------- | -------------------- | ------------ | ---------------- |
| lookup()   | Map / Object    | ✅ Yes                | ❌ No         | Simple defaults  |
| element()  | List / Tuple    | ❌ No                 | ❌ No         | Wraps index      |
| try()      | Any             | ✅ Yes                | ✅ Yes        | Best overall     |
| coalesce() | Any             | ❌ No                 | ✅ Yes        | Null-only checks |

---

## Quick Rules to Remember

* 🔑 Use **`lookup()`** for maps with defaults
* 🧠 Use **`try()`** for modern, flexible access
* ⚠️ Avoid **`element()`** unless wrapping is intentional
* 🚀 Prefer **`for_each`** over `count`
* 📛 Prefer **direct indexing** over `element()`

---

## Conclusion

Using the correct Terraform function improves:

* Safety
* Readability
* Maintainability

For new Terraform code, **`try()` + `for_each`** should be your default approach, with `lookup()` used for simple map access.
