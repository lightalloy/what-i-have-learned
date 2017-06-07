[The Transformation Priority Premise](https://8thlight.com/blog/uncle-bob/2013/05/27/TheTransformationPriorityPremise.html)

Refactorings have counterparts called transformations, simple operations that change the behavior of code.
Transformations have a preferred ordering, which can prevent impasses and long outages in red/green/refactor cycles.

> As the tests get more specific, the code gets more generic.

Transformations, ordered by complexity:

- ({}–>nil) no code at all->code that employs nil
- (nil->constant)
- (constant->constant+) a simple constant to a more complex constant
- (constant->scalar) replacing a constant with a variable or an argument
- (statement->statements) adding more unconditional statements.
- (unconditional->if) splitting the execution path
- (scalar->array)
- (array->container)
- (statement->recursion)
- (if->while)
- (expression->function) replacing an expression with a function or algorithm
- (variable->assignment) replacing the value of a variable.

## The Impasse Problem
When there's no way to pass the next test without rewriting the whole algorithm.
The premise is that if you choose the tests and implementations that employ transformations that are higher on the list, you will avoid the impasse.

## The Process
- When passing a test, prefer higher priority transformations.
- When posing a test choose one that can be passed with higher priority transformations.
- When an implementation seems to require a low priority transformation, backtrack to see if there is a simpler test to pass.

