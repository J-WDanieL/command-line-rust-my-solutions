# Note

## Generating error.out

To capture both stdout and stderr in order, use `2>&1` to merge stderr into stdout:

```bash
cat tests/inputs/fox.txt blargh tests/inputs/spiders.txt cant-touch-this > tests/expected/error.out 2>&1
```

`2>&1` redirects stderr (fd 2) to the same stream as stdout (fd 1), preserving the output order.

## 

An iterator that yields the current count and the element during iteration.

```rust
fn main() {
    let numbers = vec![10, 20, 30, 40];
    for (index, value) in numbers.iter().enumerate() {
        println!("Index: {}, Value: {}", index, value);
    }
    // Output:
    // Index: 0, Value: 10
    // Index: 1, Value: 20
    // Index: 2, Value: 30
    // Index: 3, Value: 40
}
```

## Formatted print

You can right-justify text with a specified width.

```rust
// This will output "     1".
// (Five white spaces and a "1", for a total width of 6.)
println!("{number:>6}", number=1);
```
