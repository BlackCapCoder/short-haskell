# Short Haskell

Haskell is awesome, but a little too verbose to comfortably use on the command line.
For instance, say that I have some long chain of commands that produce a list of numbers
and I want to calculate the sum with Haskell:

```bash
long | chain | of | commands | haskell 'main = interact $ show . sum . map read . lines'
```

Short Haskell is a dialect that transpiles to regular Haskell. It currently does 2 about things:


### Fuzzy function search

For every function used, check if it is in scope. If not, perform a fuzzy search on the functions that
are in scope and choose the closest match.

```haskell
su.ma rd.lns -- sum . map read . lines
```


### Holes

If `_` is used, ask ghc to find a possible function (The types have to match).

```haskell
su._rd._ -- sum . map read . lines
```


### Examples


cat

```haskell
-- id
```

tac

```haskell
rv.lns -- unlines {- implicit -} . reverse . lines
```

yes

```haskell
cy"y\n" -- cycle "y\n"
```

hello world

```haskell
"Hello, world!\n" -- "Hello, world!\n"
```

Factorial

```haskell
pod.FT1.rd -- product . enumFromTo 1 . read
```


### Other ideas

`(...)` from `control-dotdotdot` can function as both `.` and `$` (and more!), but not ` `. I could redefine ` ` to mean `...` and have something else be ` `.


Implicit `read`?


Use djinn to generate functions. Similar to `_`, but it can create new functions rather than
look for something in scope.
