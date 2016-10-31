#Sets - intersection, union, differences

A Set guarantees a collection of unique values. This means that a set can never contain multiple elements with the same value – therefore there is no need to filter out duplicates from a set.

```
import Set

set1 = Set.fromList [1,2,3,4,3,2,1]
-- Set.fromList [1,2,3,4] : Set.Set number

set2 = Set.fromList [3,4,5,6]
-- Set.fromList [3,4,5,6] : Set.Set number

intersection = Set.intersect set1 set2
-- Set.fromList [3,4] : Set.Set number

union = Set.union set1 set2
-- Set.fromList [1,2,3,4,5,6] : Set.Set number

differences = Set.diff set1 set2
-- Set.fromList [1,2] : Set.Set number
```

Sets are well suited for operations in which one need to find intersections, unions, or differences of two sets.

---

```
set1 = Set.fromList ["Jane", "Jen", "Jenny", "sam23", "__sam23"]

set2 = Set.fromList ["sam23", "__sam23"]

intersection = Set.intersect set1 set2

--returns:
--Set.fromList ["__sam23","sam23"] : Set.Set String
```
