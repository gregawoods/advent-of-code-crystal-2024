# Advent of Code

Crystal solutions to [Advent of Code](https://adventofcode.com/).

## Installation

First [install crystal](https://crystal-lang.org/install/).

Note: If on macOS, I recommend installing via homebrew because it includes [interpreter support](https://crystal-lang.org/2021/12/29/crystal-i/). The current version installed by asdf [does not support the interpreter](https://github.com/asdf-community/asdf-crystal/issues/49).

## Usage

Create a file at `.session` and enter your cookie value.

Download input for a day:

```
crystal run ./src/advent_of_code.cr -- -d 3
```

Solve a day:

```
crystal run ./src/advent_of_code.cr -- -s 1
```

## Testing

Run all tests:

```
crystal spec
```

Run a specific test:

```
crystal spec spec/01_spec.cr:8
```
